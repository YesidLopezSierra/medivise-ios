//
//  MedicationViewModel.swift
//  Medivise
//
//  Created by Sara Ortiz Drada on 28.03.24.
//

import Combine
import SwiftUI
import Foundation
import GoogleGenerativeAI

class MedicationViewModel: ObservableObject {
    @Published var medicationInfo: MedicineDetails?
    @Published var info: String?
    @Published var isLoading = false
    @Published var showErrorAlert = false
    @Published var errorMessage = ""
    @Published var filteredMedications: [Medication] = []
    @Published var medications: [Medication] = []
    @Published var isMedicationListLoading = false

    private let medicationRepository: MedicationRepository
    private let medicationFileManagerRepository: MedicationFileManagerRepository
    private let textAccumulator = TextAccumulator()

    init() {
        self.medicationRepository = MedicationRepository(service: MedicationService())
        self.medicationFileManagerRepository = MedicationFileManagerRepository(service: MedicationFileManagerService())
    }

    var model = GenerativeModel(name: "gemini-pro-vision",
                                apiKey: APIKey.default,
                                safetySettings: [
                                    SafetySetting(harmCategory: .dangerousContent, threshold: .blockNone),
                                    SafetySetting(harmCategory: .sexuallyExplicit, threshold: .blockNone)
                                ])

    //    MARK: - Functions
    func refreshMedications(for userId: String) {
        isMedicationListLoading = true
        medicationRepository.fetchMedications(for: userId) { [weak self] result in
            DispatchQueue.main.async {
                self?.isMedicationListLoading = false
                switch result {
                case .success(let medications):
                    self?.medications = medications
                    self?.cacheMedications(medications)
                case .failure(let error):
                    print("Failed to fetch medications: \(error.localizedDescription)")
                }
            }
        }
    }

    func saveMedication(medication: Medication, for userId: String) {
        medicationRepository.saveMedication(medication: medication) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self?.medications.append(medication)
                    self?.cacheMedications(self?.medications ?? [])
                case .failure(let error):
                    print("Error saving medication: \(error.localizedDescription)")
                }
            }
        }
    }

    func getMedicationBrandNames() -> [String] {
        return medications.compactMap { $0.genericName }
    }

    // MARK: - Private Methods

    private func cacheMedications(_ medications: [Medication]) {
        medicationFileManagerRepository.saveMedicationsToFileSystem(medications: medications)
    }

    func loadCachedMedications() {
        if let cachedMedications = medicationFileManagerRepository.loadMedicationsFromFileSystem() {
            self.medications = cachedMedications
        }
    }

    func reloadMedications(for userId: String) {
        isMedicationListLoading = true
        medicationRepository.fetchMedications(for: userId) { result in
            DispatchQueue.main.async {
                self.isMedicationListLoading = false
                switch result {
                case .success(let medications):
                    self.medications = medications
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func analyzeImageAndFetchMedicationInfo(_ image: UIImage) async {
        await setLoading(true)
        do {
            let fullText = await analyzeImage(image)
            await fetchMedicationInformation(from: fullText)
        }
        await setLoading(false)
    }

    private func analyzeImage(_ image: UIImage) async -> String {
        DispatchQueue.main.async {
            self.isLoading = true
        }

        let prompt = "Extract all the text in this image"
        let contentStream = model.generateContentStream(prompt, image)
        var fullText = ""

        do {
            for try await chunk in contentStream {
                if let text = chunk.text {
                    await textAccumulator.append(text)
                }
            }
            fullText = await textAccumulator.joinedText()
        } catch {
            print("An error occurred while processing the content stream: \(error)")
        }

        let infoText = fullText
        DispatchQueue.main.async {
//            self.isLoading = false
            self.info = infoText
        }
        return fullText
    }

    private func fetchMedicationInformation(from text: String) async {
        guard let textEncoded = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "http://34.29.156.157/extract-medicine-details?text=\(textEncoded)") else {
            await showError("Invalid URL or text encoding failed")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            if let jsonStr = String(data: data, encoding: .utf8) {
                print("Raw JSON response: \(jsonStr)")
            }
            let decodedResponse = try JSONDecoder().decode(MedicineDetails.self, from: data)
            await updateMedicationInfo(decodedResponse)
        } catch {
            await showError(error.localizedDescription)
        }
    }

    @MainActor private func setLoading(_ isLoading: Bool) {
        self.isLoading = isLoading
    }

    @MainActor private func updateMedicationInfo(_ medication: MedicineDetails) {
        self.medicationInfo = medication
    }

    @MainActor private func showError(_ message: String) {
        self.errorMessage = message
        self.showErrorAlert = true
        print(self.errorMessage)
    }
}

actor TextAccumulator {
    private(set) var texts = [String]()

    func append(_ text: String) {
        texts.append(text)
    }

    func joinedText(separator: String = " ") -> String {
        return texts.joined(separator: separator)
    }
}

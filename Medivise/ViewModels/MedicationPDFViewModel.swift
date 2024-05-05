//
//  MedicationPDFViewModel.swift
//  Medivise
//
//  Created by Sara Ortiz Drada on 29.04.24.
//

import Foundation

class MedicationPDFViewModel: ObservableObject {
    @Published var pdfURL: URL?
    @Published var isLoading = false

    private let medicationPDFRepository: MedicationPDFRepository

    init() {
        self.medicationPDFRepository = MedicationPDFRepository(service: MedicationPDFService())
    }

    func getPDF(userId: String) {
        self.isLoading = true
        medicationPDFRepository.checkInteractionBetween(for: userId) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let url):
                    self?.pdfURL = url
                case .failure(let failure):
                    print("Failed to get PDF: \(failure.localizedDescription)")
                }
            }
        }
    }
}

//
//  MedicationFileManagerService.swift
//  Medivise
//
//  Created by Sara Ortiz Drada on 11.04.24.
//

import Foundation

protocol MedicationFileManagerServiceProtocol {
    func saveMedicationsToFileSystem(medications: [Medication])
    func loadMedicationsFromFileSystem() -> [Medication]?
    func clearMedicationsCache()
}

class MedicationFileManagerService: MedicationFileManagerServiceProtocol {
    private var cacheFileURL: URL {
        let fileManager = FileManager.default
        let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDir.appendingPathComponent("medications_cache").appendingPathExtension("json")
    }

    func saveMedicationsToFileSystem(medications: [Medication]) {
        do {
            let data = try JSONEncoder().encode(medications)
            try data.write(to: cacheFileURL, options: .atomic)
        } catch {
            print("Error saving medications to file system: \(error)")
        }
    }

    func loadMedicationsFromFileSystem() -> [Medication]? {
        do {
            let data = try Data(contentsOf: cacheFileURL)
            let medications = try JSONDecoder().decode([Medication].self, from: data)
            return medications
        } catch {
            print("Error loading medications from file system: \(error)")
            return nil
        }
    }

    func clearMedicationsCache() {
        let fileManager = FileManager.default
        let cacheURL = cacheFileURL

        if fileManager.fileExists(atPath: cacheURL.path) {
            do {
                try fileManager.removeItem(at: cacheURL)
                print("Cache successfully cleared.")
            } catch {
                print("Failed to clear cache: \(error.localizedDescription)")
            }
        }
    }
}

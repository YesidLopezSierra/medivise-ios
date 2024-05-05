//
//  MedicationFileManagerRepository.swift
//  Medivise
//
//  Created by Sara Ortiz Drada on 11.04.24.
//

import Foundation

class MedicationFileManagerRepository {
    private let medicationFileManagerService: MedicationFileManagerServiceProtocol

    init(service: MedicationFileManagerServiceProtocol) {
        self.medicationFileManagerService = service
    }

    func saveMedicationsToFileSystem(medications: [Medication]) {
        medicationFileManagerService.saveMedicationsToFileSystem(medications: medications)
    }

    func loadMedicationsFromFileSystem() -> [Medication]? {
        medicationFileManagerService.loadMedicationsFromFileSystem()
    }

    func clearMedicationsCache() {
        medicationFileManagerService.clearMedicationsCache()
    }
}

//
//  MedicationRepository.swift
//  Medivise
//
//  Created by Sara Ortiz Drada on 05.04.24.
//

import Foundation

class MedicationRepository {
    private let medicationService: MedicationServiceProtocol

    init(service: MedicationServiceProtocol) {
        self.medicationService = service
    }

    func fetchMedications(for userId: String, completion: @escaping (Result<[Medication], Error>) -> Void) {
        medicationService.fetchMedications(for: userId, completion: completion)
    }

    func saveMedication(medication: Medication, completion: @escaping (Result<String, Error>) -> Void) {
        medicationService.saveMedication(medication: medication, completion: completion)
    }

}

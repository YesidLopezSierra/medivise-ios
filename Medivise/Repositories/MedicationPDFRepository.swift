//
//  MedicationPDFRepository.swift
//  Medivise
//
//  Created by Sara Ortiz Drada on 29.04.24.
//

import Foundation

class MedicationPDFRepository {
    private let service: MedicationPDFServiceProtocol

    init(service: MedicationPDFServiceProtocol) {
        self.service = service
    }

    func checkInteractionBetween(for user: String, completion: @escaping (Result<URL, Error>) -> Void) {
        service.downloadPDF(for: user, completion: completion)
    }
}

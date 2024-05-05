//
//  DDICheckerRepository.swift
//  Medivise
//
//  Created by Sara Ortiz Drada on 28.04.24.
//

import Foundation

class DDICheckerRepository {
    private let service: DDICheckerServiceProtocol

    init(service: DDICheckerServiceProtocol) {
        self.service = service
    }

    func checkInteractionBetween(drugOne: String, drugTwo: String, completion: @escaping (Result<Interaction, Error>) -> Void) {
        service.checkInteractionBetween(drugOne: drugOne, drugTwo: drugTwo, completion: completion)
    }

    func fetchFoodInteractions(for medicine: String, completion: @escaping (Result<[FoodInteraction], Error>) -> Void) {
        service.fetchFoodInteractions(for: medicine, completion: completion)
    }
}

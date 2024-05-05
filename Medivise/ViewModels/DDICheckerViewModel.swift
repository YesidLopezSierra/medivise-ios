//
//  DDICheckerViewModel.swift
//  Medivise
//
//  Created by Sara Ortiz Drada on 19.04.24.
//

import Foundation

class DDICheckerViewModel: ObservableObject {

    @Published var isDDICheckerLoading = false
    @Published var isFoodInteractionListLoading = false
    @Published var interaction: Interaction?
    @Published var foodInteractions: [FoodInteraction] = []

    private let dDICheckerRepository: DDICheckerRepository

    init() {
        self.dDICheckerRepository = DDICheckerRepository(service: DDICheckerService())
    }

    func checkInteractionBetween(_ drugOne: String, _ drugTwo: String) {
        isDDICheckerLoading = true
        interaction = Interaction()

        dDICheckerRepository.checkInteractionBetween(drugOne: drugOne, drugTwo: drugTwo) { [weak self] result in
            DispatchQueue.main.async {
                self?.isDDICheckerLoading = false
                switch result {
                case .success(let interaction):
                    self?.interaction = interaction
                case .failure(let failure):
                    print("Failed to fetch D-D interactions: \(failure.localizedDescription)")
                }
            }
        }
    }

    func checkFoodInteractionsFor(drug: String) {
        foodInteractions = []
        isFoodInteractionListLoading = true
        dDICheckerRepository.fetchFoodInteractions(for: drug) { [weak self] result in
            DispatchQueue.main.async {
                self?.isFoodInteractionListLoading = false
                switch result {
                case .success(let interactions):
                    self?.foodInteractions = interactions
                case .failure(let failure):
                    print("Failed to fetch food interactions: \(failure.localizedDescription)")
                }
            }
        }
    }
}

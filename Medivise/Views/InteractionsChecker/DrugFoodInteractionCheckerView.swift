//
//  DrugFoodInteractionCheckerView.swift
//  Medivise
//
//  Created by Sara Ortiz Drada on 28.04.24.
//

import SwiftUI

struct DrugFoodInteractionCheckerView: View {
    @State private var textField: String = ""
    @StateObject var viewModel = DDICheckerViewModel()
    @EnvironmentObject var medicationViewModel: MedicationViewModel

    var body: some View {
        VStack {
                TextFieldWithButton(text: $textField, placeholder: "Enter medication name", action: {
                    self.textField = "Scanned text"
                }, dropDownItem: medicationViewModel.getMedicationBrandNames())
                .padding(.bottom)

                WideButton(
                    text: "Check Interactions",
                    action: {
                        viewModel.checkFoodInteractionsFor(drug: textField)
                    },
                    backgroundColor: viewModel.isFoodInteractionListLoading ? .gray : .darkpurple
                )
                .cornerRadius(40)
                .padding(.horizontal, 75)
                .padding(.top, 20)
                .disabled(viewModel.isFoodInteractionListLoading)

                if viewModel.isFoodInteractionListLoading {
                    WaveLoadingView()
                        .offset(y: 50)
                }

                if let interaction = viewModel.interaction, !viewModel.isDDICheckerLoading {
                    InteractionDetailView(interaction: interaction)
                        .padding(.top)
                }
                FoodInteractionsView(interactions: viewModel.foodInteractions)
            }
            .padding(.top, 1)
    }
}


#Preview {
    DrugFoodInteractionCheckerView()
        .environmentObject(MedicationViewModel())
}

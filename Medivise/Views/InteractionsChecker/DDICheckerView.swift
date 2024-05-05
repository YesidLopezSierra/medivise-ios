//
//  DDICheckerView.swift
//  Medivise
//
//  Created by Sara Ortiz Drada on 19.04.24.
//

import SwiftUI

struct DDICheckerView: View {
    @State private var textField: String = ""
    @State private var textField2: String = ""
    @StateObject var viewModel = DDICheckerViewModel()
    @EnvironmentObject var medicationViewModel: MedicationViewModel

    var body: some View {
        ScrollView {
            VStack {
                TextFieldWithButton(text: $textField, placeholder: "Enter medication name", action: {
                    self.textField = "Scanned text 1"
                }, dropDownItem: medicationViewModel.getMedicationBrandNames())
                .padding(.bottom)

                TextFieldWithButton(text: $textField2, placeholder: "Enter medication name", action: {
                    self.textField2 = "Scanned text 2"
                }, dropDownItem: medicationViewModel.getMedicationBrandNames())

                WideButton(
                    text: "Check Interactions",
                    action: {
                        viewModel.checkInteractionBetween(textField, textField2)
                    },
                    backgroundColor: viewModel.isDDICheckerLoading ? .gray : .darkpurple
                )
                .cornerRadius(40)
                .padding(.horizontal, 75)
                .padding(.top, 20)
                .disabled(viewModel.isDDICheckerLoading)

                if viewModel.isDDICheckerLoading {
                    WaveLoadingView()
                        .offset(y: 50)
                }

                if let interaction = viewModel.interaction, !viewModel.isDDICheckerLoading {
                    InteractionDetailView(interaction: interaction)
                    .padding(.top)
                }
            }
            .padding(.top, 1)
        }
        .padding()
    }
}

struct TextFieldWithButton: View {
    @Binding var text: String
    var placeholder: String
    var action: () -> Void
    var dropDownItem: [String]

    var body: some View {
        ZStack {
            TextField(placeholder, text: $text)
                .customTextField()
            HStack {
                Spacer()
                Menu {
                    ForEach(dropDownItem, id: \.self){ item in
                        Button(item) {
                            self.text = item
                        }
                    }
                } label: {
                    VStack {
                        Image(systemName: "chevron.down")
                            .foregroundStyle(.darkpurple)
                            .padding()
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    DDICheckerView()
        .environmentObject(MedicationViewModel())
}

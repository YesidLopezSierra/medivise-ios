//
//  InteractionDetailView.swift
//  Medivise
//
//  Created by Sara Ortiz Drada on 28.04.24.
//

import SwiftUI

struct InteractionDetailView: View {
    var interaction: Interaction

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Text(interaction.drugOne!)
                        .font(.title2)
                        .fontWeight(.bold)
                    Image(systemName: "arrow.left.arrow.right")
                        .foregroundColor(.darkpurple)
                    Text(interaction.drugTwo!)
                        .font(.title2)
                        .fontWeight(.bold)
                }
                .frame(maxWidth: .infinity, alignment: .center)

                VStack(alignment: .center) {
                    Button(action: {}) {
                        Text(interaction.severity!.rawValue)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                            .background(Capsule().fill(.darkpurple))
                            .foregroundColor(.white)
                    }

                }
                .frame(maxWidth: .infinity, alignment: .center)
                if interaction.severity! != Severity.noInformation {
                    Divider()

                    DescriptionSection(title: "DESCRIPTION", description: interaction.description!)
                    Divider()

                    DescriptionSection(title: "EXTENDED DESCRIPTION", description: interaction.extendedDescription!)
                }
                Spacer()
                WarningView()
                    .padding(.bottom)
            }
            .padding()
        }
    }
}

struct DescriptionSection: View {
    var title: String
    var description: String
    @State private var isTextExpanded: Bool = false

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .fontWeight(.semibold)
                .padding(.bottom, 5)
            ZStack {
                HStack{
                    Text(description)
                        .lineLimit(isTextExpanded ? nil : 2)
                        .frame(alignment: .leading)
                    Spacer()
                }

                if !isTextExpanded {
                    HStack {
                        Spacer()
                        LinearGradient(gradient: Gradient(colors: [.white.opacity(0.0), .white
                                                                  ]), startPoint: .leading, endPoint: .bottom)
                        .frame(width: 200, height: 20)
                        .offset(y: 12)
                    }
                }
            }
            HStack {
                Spacer()
                Button(action: {
                    withAnimation(nil) {
                        isTextExpanded.toggle()
                    }
                }) {
                    Text(isTextExpanded ? "READ LESS" : "READ MORE")
                        .underline()
                        .fontWeight(.bold)
                        .foregroundColor(.darkpurple)
                        .frame(alignment: .trailing)
                        .padding(.top, 3)
                }
            }
        }
    }
}

#Preview {
    InteractionDetailView(interaction: Interaction(drugOne: "Isotretinon",
                                                   drugTwo: "Doxycycline",
                                                   severity: Severity.moderate,
                                                   description: "The risk or severity of pseudotumor cerebri can be increased when Isotretinoin is combined with Doxycycline.",
                                                   extendedDescription: "Tetracycline antibiotics are associated with a risk of increased intracranial hypertension. etracycline antibiotics are associated with a risk of increased intracranial hypertension. etracycline antibiotics are associated with a risk of increased intracranial hypertension."))
}

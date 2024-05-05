//
//  FoodInteractionsView.swift
//  Medivise
//
//  Created by Sara Ortiz Drada on 01.05.24.
//

import SwiftUI

struct FoodInteractionsView: View {
    var interactions: [FoodInteraction]

    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ForEach(interactions, id: \.name) { interaction in
                    InteractionCardView(interaction: interaction)
                }
            }
            .padding(.top)
        }
    }
}


struct InteractionCardView: View {
    var interaction: FoodInteraction

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(interaction.name)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .padding([.top, .horizontal])

            Text(interaction.description)
                .foregroundColor(.secondary)
                .padding([.bottom, .horizontal])
            
            Divider()

        }
        .background(Color.white)
        .cornerRadius(10)
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
}



#Preview {
    let sampleInteractions = [
        FoodInteraction(name: "Alcohol", description: "Can increase the risk of liver damage."),
        FoodInteraction(name: "Niacin", description: "Can increase the risk of muscle damage."),
        FoodInteraction(name: "Warfarin", description: "Can increase the risk of bleeding."),
        FoodInteraction(name: "Digoxin", description: "Can increase the risk of digoxin toxicity."),
        FoodInteraction(name: "Erythromycin, clarithromycin, telithromycin", description: "Can increase the risk of muscle damage."),
        FoodInteraction(name: "Cyclosporine", description: "Can increase the risk of kidney damage."),
        FoodInteraction(name: "Itconazole, ketoconazole", description: "Can increase the risk of liver damage."),
        FoodInteraction(name: "Gemfibrozil", description: "Can increase the risk of muscle damage."),
        FoodInteraction(name: "Fenofibrate", description: "Can increase the risk of muscle damage."),
        FoodInteraction(name: "Ezetimibe", description: "Can decrease the effectiveness of Lipitor."),
        FoodInteraction(name: "Colesevelam", description: "Can decrease the effectiveness of Lipitor.")
    ]


    return FoodInteractionsView(interactions: sampleInteractions)
}

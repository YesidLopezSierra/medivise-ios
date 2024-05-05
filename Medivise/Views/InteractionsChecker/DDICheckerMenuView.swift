//
//  DDICheckerMenuView.swift
//  Medivise
//
//  Created by Sara Ortiz Drada on 28.04.24.
//

import SwiftUI

struct DDICheckerMenuView: View {
    @State private var selectedTab: Tab = .drugInteractions

    var body: some View {
        ZStack {
            AppColor.darkblue.color
                .edgesIgnoringSafeArea(.top)
            VStack {
                VStack(alignment: .leading, spacing: 15) {
                    Text("Ensure Your Safety")
                        .font(.title2)
                        .fontWeight(.medium)
                    Text("Quickly check for potential interactions between medications and foods.")
                }
                .padding(.horizontal, 45)

                ZStack {
                    HStack {
                        CustomTab(title: "D-D INTERACTIONS", selectedTab: $selectedTab, currentTab: .drugInteractions)
                        CustomTab(title: "FOOD INTERACTIONS", selectedTab: $selectedTab, currentTab: .foodInteractions)
                    }
                    .padding(.top, 20)

                    VStack {
                        switch selectedTab {
                        case .drugInteractions:
                            DDICheckerView()
                        case .foodInteractions:
                            DrugFoodInteractionCheckerView()
                        }
                    }
                    .padding(.top, 70)
                    .padding(.bottom, 50)
                }
            }
            .padding(.top, 40)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
            .edgesIgnoringSafeArea(.bottom)
            .shadow(radius: 10)
        }
    }
}

enum Tab {
    case drugInteractions, foodInteractions
}

struct CustomTab: View {
    let title: String
    @Binding var selectedTab: Tab
    let currentTab: Tab
    let blue: Color = AppColor.darkblue.color

    var body: some View {
        VStack {
            Text(title)
                .font(.subheadline)
                .foregroundColor(selectedTab == currentTab ? blue : .gray)
                .padding(.bottom, 1)

            if selectedTab == currentTab {
                Rectangle()
                    .fill(blue)
                    .frame(height: 3)
            }
            Spacer()
        }
        .frame(width: 170)
        .onTapGesture {
            selectedTab = currentTab
        }
    }
}

#Preview {
    DDICheckerMenuView()
}

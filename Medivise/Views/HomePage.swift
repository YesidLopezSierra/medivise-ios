//
//  HomePage.swift
//  Medivise
//
//  Created by Sara Ortiz Drada on 26.03.24.
//

import SwiftUI

struct HomePage: View {
    @State private var selection = 2
    @EnvironmentObject var userFormViewModel: UserFormViewModel

    var body: some View {
        NavigationStack {
            TabView(selection: $selection) {
                Group {
                    DDICheckerMenuView()
                        .tabItem {
                            Image(systemName: "checkmark.circle")
                            Text("Interactions")
                        }
                        .tag(1)


                    DashboardView(userId: userFormViewModel.getUserId(), user: userFormViewModel.getUser())
                        .tabItem {
                            Image(systemName: "house.fill")
                            Text("Dashboard")
                        }.tag(2)

                    MedicationPDFView(user: userFormViewModel.getUser())
                        .tabItem {
                            Image(systemName: "doc.fill")
                            Text("PDF")
                        }.tag(3)
                }
                .toolbarBackground(.white, for: .tabBar)
                            .toolbarBackground(.visible, for: .tabBar)
            }
            .tint(.darkblue)
        }
    }
}


#Preview {
    HomePage()
        .environmentObject(UserFormViewModel())
        .environmentObject(MedicationViewModel())
}

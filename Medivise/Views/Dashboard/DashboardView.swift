//
//  DashboardView.swift
//  Medivise
//
//  Created by Sara Ortiz Drada on 06.04.24.
//

import SwiftUI

struct DashboardView: View {
    let userId: String?
    let user: User?

    var body: some View {
        VStack {
            if (user == nil ) {
                WelcomeScreenView()
            } else {
                if let user = user {
                    MedicationDashboardView(userId: user.id!, user: user)
                }
            }
        }
    }
}

#Preview {
    DashboardView(userId: "", user: User(age: 1, allergies: [], bloodType: BloodType.aNegative, gender: Gender.female, height: 0.0, medicalConditions: [], name: "Pedro", weight: 0.0))
        .environmentObject(MedicationViewModel())
}

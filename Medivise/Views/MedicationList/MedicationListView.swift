//
//  MedicationListView.swift
//  Medivise
//
//  Created by Sara Ortiz Drada on 10.04.24.
//

import SwiftUI

struct MedicationListView: View {
    @EnvironmentObject var medicationViewModel: MedicationViewModel
    let userId: String

    var body: some View {
        VStack(alignment: .center) {
            if medicationViewModel.isMedicationListLoading {
                WaveLoadingView()
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.vertical)
            } else {
                ForEach(medicationViewModel.medications.reversed()) { medication in
                    MedicationRowView(medication: medication)
                        .padding(.bottom, 3)
                }
            }
        }
        .padding(.horizontal)
        .onAppear {
            if medicationViewModel.medications.isEmpty {
                medicationViewModel.refreshMedications(for: userId)
            }
        }
        .refreshable {
            medicationViewModel.refreshMedications(for: userId)
        }
    }
}

#Preview {
    MedicationListView(userId: "")
        .environmentObject(MedicationViewModel())
}



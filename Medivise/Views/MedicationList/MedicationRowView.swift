//
//  MedicationRowView.swift
//  Medivise
//
//  Created by Sara Ortiz Drada on 11.04.24.
//

import SwiftUI

struct MedicationRowView: View {
    let medication: Medication

    var body: some View {
        HStack(alignment: .center) {
            ZStack(alignment: .center) {
                Circle()
                    .frame(width: 70)
                    .foregroundStyle(.white)
                Image(systemName: "pills")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30)
                    .foregroundStyle(AppColor.blue.color)
            }
            .padding(.trailing)
            VStack(alignment: .leading, spacing: 8) {
                Text(medication.brandName!)
                    .font(.headline)
                    .bold()
                Text(medication.type!.appending(", \(Int(medication.strength!)) \(medication.unit!)"))
                    .font(.subheadline)
                Text(medication.frequency!.joined(separator: ", "))
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .font(.subheadline)
            }
            Spacer()
            NavigationLink(destination: MedicationDetailView(medication: medication)) {
                Image(systemName: "chevron.right")
                    .foregroundColor(AppColor.blue.color)
                    .font(.title3)
            }
            .navigationTitle("Home")
        }
        .padding()
        .background(AppColor.blue.color.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    MedicationRowView(medication: Medication.sampleData[0])
}

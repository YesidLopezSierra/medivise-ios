//
//  MedicationDetailView.swift
//  Medivise
//
//  Created by Sara Ortiz Drada on 01.05.24.
//

import SwiftUI

struct MedicationDetailView: View {
    let medication: Medication
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ZStack(alignment: .top) {
                    MedicineHeader()
                    MedicineInfo(medication: medication)
                }
            }
        }
        .ignoresSafeArea()
    }
}

struct MedicineHeader: View {
    var body: some View {
        Group {
            LinearGradient(gradient:
                            Gradient(colors: [
                                AppColor.darkpurple.color,
                                AppColor.lightblue.color]),
                           startPoint: .top,
                           endPoint: .bottom)
            .frame(height: 380)
            .edgesIgnoringSafeArea(.top)
            .offset(CGSize(width: 0, height: -10))

            Image("41")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200)
                .padding(.top, 100)
        }
    }
}

struct MedicineInfo: View {
    let medication: Medication
    var body: some View {
        VStack {
            ZStack {
                Color.white
                    .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
                    .shadow(radius: 10)
                    .edgesIgnoringSafeArea(.bottom)

                VStack(alignment: .leading) {
                    VStack(spacing: 5){
                        Text(medication.brandName!)
                            .font(.title2)
                            .fontWeight(.medium)

                        Text(medication.genericName!)
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)

                    Group {
                        Text("DOSAGE:")
                            .foregroundStyle(.gray)
                            .font(.subheadline)
                        Divider()
                        Text(medication.type!.appending(", \(Int(medication.strength!)) \(medication.unit!)"))
                            .padding(.bottom, 20)

                        Text("PURPOSE:")
                            .foregroundStyle(.gray)
                            .font(.subheadline)
                        Divider()
                        Text(medication.purpose!)
                            .padding(.bottom, 20)

                        Text("FREQUENCY:")
                            .foregroundStyle(.gray)
                            .font(.subheadline)
                        Divider()
                        Text(medication.frequency!.joined(separator: ", "))
                            .multilineTextAlignment(.leading)
                            .padding(.bottom, 20)

                        Text("NOTES:")
                            .foregroundStyle(.gray)
                            .font(.subheadline)
                        Divider()
                        Text(medication.notes!)
                            .padding(.bottom, 20)
                    }
                    .padding(.horizontal)
                    Spacer()
                }
                .padding(.top, 40)
                .padding(.bottom, 20)
                .padding(.horizontal)
            }
            .frame(height: 650)
        }
        .padding(.top, 340)
    }
}

struct MedicineInfoCard: View {
    var headline: String
    var subheadline: String
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(subheadline)
                    .foregroundStyle(.darkblue)
                    .font(.caption)
                Text(headline)
                    .font(.headline)
                    .fontWeight(.medium)
            }
            .padding(.horizontal)
            .frame(height: 80, alignment: .leading)
            .background(.white)
            Spacer()
        }
        .frame(maxWidth: 160)
        .overlay(
            RoundedRectangle(cornerRadius: 20).stroke(.darkblue))
    }
}

#Preview {
    MedicationDetailView(medication: Medication(id: "id", brandName: "Brand Name", genericName: "Generic Name", type: "Tablet", strength: 100.0, unit: "mg", purpose: "Fever", frequency: ["Monday", "Wednesday"], notes: "Take with food in the morning", userId: "userId"))
}

//
//  MedicationDashboardView.swift
//  Medivise
//
//  Created by Sara Ortiz Drada on 18.04.24.
//

import SwiftUI

struct MedicationDashboardView: View {
    @State private var showingSheet = false
    let userId: String
    let user: User

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(alignment: .leading) {
                    header
                        .padding(.bottom)
                    myHealthSection
                        .padding(.bottom)
                    medicationsTitle
                    ZStack(alignment: .bottomTrailing) {
                        MedicationListView(userId: userId)
                            .padding(.bottom)
                    }
                    Spacer()
                        .frame(height: 100)
                }
            }
            .ignoresSafeArea()

            addMedicationButton
                .padding(.trailing, 30)
                .padding(.bottom)
        }
    }

    private var myHealthSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("My Health")
                .font(.title2)
                .fontWeight(.medium)
                .padding(.leading)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    HealthCardView(title: "Weight", icon: "scalemass.fill", measurement: "\(user.weight)", unit: "kg", amplitude: 25, wavelength: 110)
                    HealthCardView(title: "Heigth", icon: "ruler.fill", measurement: "\(user.height)", unit: "cm", amplitude: 10, wavelength: 180)
                }
                .padding()
            }
        }
    }

    private var medicationsTitle: some View {
        VStack(alignment: .leading) {
            Text("My Medications")
                .font(.title2)
                .fontWeight(.medium)
                .padding(.leading)
        }
    }
    private var header: some View {
        ZStack(alignment: .top) {
            LinearGradient(gradient:
                            Gradient(colors: [
                                AppColor.darkblue.color,
                                AppColor.blue.color]),
                           startPoint: .top,
                           endPoint: .bottom)
            .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
            .shadow(radius: 10)
            .edgesIgnoringSafeArea(.all)
            .offset(CGSize(width: 0, height: -10))

            Image("40")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 160)
                .offset(CGSize(width: 100, height: 85))

            HStack {
                VStack(alignment: .leading) {
                    Text("Welcome,")
                    Text("\(user.name) 👋")
                        .font(.title2)
                        .fontWeight(.medium)
                        .padding(.bottom)
                    Text("Safely manage your \nmedications in one place.")
                        .font(.subheadline)

                }
                Spacer()
            }
            .padding(.top, 70)
            .foregroundStyle(.white)
            .padding(.leading, 30)

        }
        .frame(height: 205)
    }

    private var addMedicationButton: some View {
        HStack {
            Spacer()
            Button {
                showingSheet.toggle()
            } label: {
                Image(systemName: "plus")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(17)
                    .background(.darkpurple)
                    .clipShape(Circle())
                    .background (
                        Circle()
                            .shadow(color: .darkpurple, radius: 8)
                    )
            }
            .sheet(isPresented: $showingSheet,
                   onDismiss: { }) {
                ImageUploadView()
            }
        }
    }
}

#Preview {
    MedicationDashboardView(userId: "", user: User(age: 0, allergies: [], bloodType: BloodType.aNegative, gender: Gender.female, height: 0.0, medicalConditions: [], name: "Pedro", weight: 0.0))
        .environmentObject(MedicationViewModel())
}


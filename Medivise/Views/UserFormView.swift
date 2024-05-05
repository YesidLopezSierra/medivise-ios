//
//  Sample.swift
//  Medivise
//
//  Created by Sara Ortiz Drada on 11.04.24.
//

import SwiftUI

struct UserFormView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: UserFormViewModel
    @State private var stepIndex = 0
    @State private var progressBarValue: Float = 0.33

    var body: some View {
        ZStack {
            AppColor.darkblue.color
                .edgesIgnoringSafeArea(.top)

            VStack {
                ProgressBar(value: progressBarValue)
                    .frame(height: 10)
                    .padding(.horizontal, 80)
                    .padding(.top, 25)
                Spacer()
                Group {
                    if stepIndex == 0 {
                        personalInfoForm
                    } else if stepIndex == 1 {
                        medicalDetailsForm
                    }
                }
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
                .edgesIgnoringSafeArea(.bottom)
                .frame(height: 575)
                .shadow(radius: 10)
            }
            .padding(.top)

            Image("medical history")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 200)
                .padding(.bottom, 425)
        }
    }

    private var personalInfoForm: some View {
        VStack(spacing: 20) {
            Section(header:
                        Text("Personal Information")
                .font(.title2)
                .padding(.top, 100)
            ) {
                TextField("Name", text: $viewModel.name)
                    .customTextField()
                TextField("Age", text: $viewModel.age)
                    .keyboardType(.numberPad)
                    .customTextField()
                HStack {
                    TextField("Height (cm)", text: $viewModel.height)
                        .keyboardType(.decimalPad)
                        .customTextField()
                    TextField("Weight (kg)", text: $viewModel.weight)
                        .keyboardType(.decimalPad)
                        .customTextField()
                }
                Picker("Gender", selection: $viewModel.gender) {
                    ForEach(Gender.allCases) { gender in
                        Text(gender.rawValue).tag(gender)
                    }
                }.pickerStyle(.palette)
            }
            Button("Next", action: {
                stepIndex = 1
                progressBarValue = 0.66
            })  .font(.headline)
                .frame(maxWidth: .infinity)
                .fontWeight(.medium)
                .foregroundColor(.white)
                .padding()
                .background(.darkpurple)
                .cornerRadius(40)
                .padding(.horizontal, 75)
                .padding(.top, 39)

            Spacer()
        }
        .padding(.horizontal)
    }

    private var medicalDetailsForm: some View {
            VStack(spacing: 20) {
                Section(header: Text("Medical Details")
                    .font(.title2)
                    .padding(.top, 100)) {
                    HStack {
                        Text("Blood Type:")
                            .font(.subheadline)
                            .padding(.horizontal)
                            .padding(.vertical, 12)
                        Spacer()
                        Picker("Blood Type", selection: $viewModel.selectedBloodType) {
                            ForEach(BloodType.allCases, id: \.self) { bloodType in
                                Text(bloodType.rawValue).tag(bloodType)
                            }
                        }
                        .pickerStyle(.menu)
                        .tint(.darkpurple)
                    }
                    TextField("Allergies (comma separated)", text: $viewModel.allergies, axis: .vertical)
                        .lineLimit(3, reservesSpace: true)
                        .customTextField()
                    TextField("Medical Conditions (comma separated)", text: $viewModel.medicalConditions, axis: .vertical)
                        .lineLimit(3, reservesSpace: true)
                        .customTextField()
                }

                Button("Back", action: {
                    stepIndex = 0
                    progressBarValue = 0.33
                })
                .font(.headline)
                    .frame(maxWidth: .infinity)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .padding()
                    .background(.darkpurple)
                    .cornerRadius(40)
                    .padding(.horizontal, 75)
                    .padding(.top, 20)

                WideButton(
                    text: "Save",
                    action: {
                        progressBarValue = 1
                        viewModel.createUser()
                        presentationMode.wrappedValue.dismiss()
                    },
                    backgroundColor: .darkpurple
                )
                .cornerRadius(40)
                .padding(.horizontal, 75)
                Spacer()
            }
            .padding(.horizontal)
    }
}

struct ProgressBar: View {
    var value: Float

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width , height: 8)
                    .opacity(0.3)
                    .foregroundColor(Color(.white))

                Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: 8)
                    .foregroundColor(Color("darkestblue"))
                    .animation(.linear, value: value)
            }.cornerRadius(45.0)
        }
    }
}

#Preview {
    UserFormView()
        .environmentObject(UserFormViewModel())
}

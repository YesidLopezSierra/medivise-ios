//
//  MedicationFormView.swift
//  Medivise
//
//  Created by Sara Ortiz Drada on 27.03.24.
//

import SwiftUI

struct MedicationFormView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    Spacer()
                        .frame(height: 5)
                    textFieldFor("Brand Name", text: $brandName)
                    textFieldFor("Generic Name", text: self.$genericName)
                    textFieldFor("Purpose of Medication", text: $purpose)

                    HStack {
                        textFieldFor("Dosage", text: self.$strength)
                            .keyboardType(.numberPad)
                        unitPicker
                    }
                    typePicker

                    NavigationLink(destination: frequencyPicker) {
                        VStack(alignment: .leading) {
                            HStack {
                                Text("When To Take:")
                                    .foregroundStyle(.darkpurple)
                                Spacer()
                            }
                            .padding(.bottom, 4)
                            if !frequency.isEmpty {
                                Text(frequency.joined(separator: ", "))
                                    .multilineTextAlignment(.leading)
                                    .foregroundStyle(.gray)
                            }
                        }
                        .padding(.leading, 5)
                    }

                    TextField("Add any special instructions or notes", text: self.$notes, axis: .vertical)
                        .font(.body)
                        .lineLimit(3, reservesSpace: true)
                        .customTextField()
                        .padding(.bottom)
                }
                .padding(.horizontal)
                .onTapGesture {
                    hideKeyboard()
                }
            }
            WideButton(text: "Add Medication",
                       action: { viewModel.saveMedication(medication:
                                                            Medication(brandName: brandName,
                                                                       genericName: genericName,
                                                                       type: type,
                                                                       strength: Double(strength),
                                                                       unit: unit,
                                                                       purpose: purpose,
                                                                       frequency: frequency,
                                                                       notes: notes,
                                                                       userId: userFormViewModel.getUserId()), for: userFormViewModel.getUserId()!)
                presentationMode.wrappedValue.dismiss() },
                       backgroundColor: .darkpurple)
            .cornerRadius(40)
            .padding(.horizontal, 45)
        }
        .onAppear {
            brandName = viewModel.medicationInfo?.brandName?.capitalized ?? ""
            genericName = viewModel.medicationInfo?.genericName ?? ""
            strength = viewModel.medicationInfo?.strength != nil ? "\(viewModel.medicationInfo?.strength! ?? 0)" : ""
            type = viewModel.medicationInfo?.type ?? ""
            unit = viewModel.medicationInfo?.unit ?? "mg"
            purpose = viewModel.medicationInfo?.purpose ?? ""
        }
    }

    let medicationTypes = ["Capsule", "Tablet", "Liquid", "Topical", "Other", "Caplets", "Cream", "Device", "Drops", "Foam", "Gel", "Inhaler", "Injection", "Lotion", "Ointment", "Patch", "Powder", "Spray", "Suppository", "Suspension", "Soft Gels"]

    let medicationUnits = ["mg", "mcg", "g", "ml", "%"]
    let options = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

    @State private var brandName: String = ""
    @State private var genericName: String = ""
    @State private var strength: String = ""
    @State private var frequency: [String] = ["Monday"]
    @State private var type: String = "Capsule"
    @State private var unit: String = "mg"
    @State private var notes: String = ""
    @State private var purpose: String = ""

    @EnvironmentObject  var viewModel: MedicationViewModel
    @EnvironmentObject var userFormViewModel: UserFormViewModel
    @Environment(\.presentationMode) var presentationMode


    private var frequencyPicker: some View {
        List(options, id: \.self) { option in
            HStack {
                Text(option)
                Spacer()
                if frequency.contains(option) {
                    Image(systemName: "checkmark")
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                if let index = frequency.firstIndex(of: option) {
                    frequency.remove(at: index)
                } else {
                    frequency.append(option)
                }

            }
        }
    }
    private var unitPicker: some View {
        Picker("Medication Unit", selection: $unit) {
            ForEach(medicationUnits, id: \.self) {
                Text($0)
            }
        }
        .tint(.darkpurple)
        .pickerStyle(.menu)
        .padding(.horizontal, 5)
    }
    private var typePicker: some View {
        Picker("Form of Medication:", selection: $type) {
            ForEach(medicationTypes, id: \.self) {
                Text($0)
            }
        }
        .tint(.darkpurple)
        .pickerStyle(.navigationLink)
        .padding(.horizontal, 5)
    }

    private func textFieldFor(_ name: String, text: Binding<String>) -> some View {
        TextField(name, text: text)
            .customTextField()
    }
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


#Preview {
    return MedicationFormView()
        .environmentObject(UserFormViewModel())
        .environmentObject(MedicationViewModel())
}

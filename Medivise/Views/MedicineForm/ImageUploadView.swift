//
//  ImageUploadView.swift
//  Medivise
//
//  Created by Sara Ortiz Drada on 27.03.24.
//

import SwiftUI
import UIKit

struct ImageUploadView: View {
    var body: some View {
        VStack {
            header
                .padding(.top, 30)
            if let selectedImage = selectedImage {
                imagePreview(selectedImage)
                    .frame(height: 200)
                    .padding(.bottom)
                    .padding(.top)
                Spacer()

                if showMedicationForm && !medicationViewModel.isLoading {
                    MedicationFormView()
                } else {
                    if medicationViewModel.isLoading {
                        WaveLoadingView()
                            .offset(y: -50)
                    }
                    getMedicationInformationButton
                }

            } else {
                Spacer()
                selectImageButton
                    .padding(.top, 240)
            }
        }
        .padding(.vertical)
        .confirmationDialog("Select Image", isPresented: $showSelection, titleVisibility: .hidden) {
            Button("Camera") {
                sourceType = .camera
                showPicker = true
            }
            Button("Photos") {
                sourceType = .photoLibrary
                showPicker = true
            }
        }
        .fullScreenCover(isPresented: $showPicker) {
            ImagePickerView(sourceType: sourceType) { image in
                self.selectedImage = image
            }
        }
    }

    @EnvironmentObject  var medicationViewModel: MedicationViewModel
    @State private var showSelection: Bool = false
    @State private var showPicker: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    @State private var showMedicationForm: Bool = false

    private var header: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(selectedImage == nil ? "Upload Medication Image" : "Confirm Image Selection")
                .font(.title2)
                .fontWeight(.medium)
            Text("Please upload an image of your medication. Ensure the label is clear and legible to assist with verification")
            
        }
        .padding(.horizontal, 45)
        .frame(maxWidth: .infinity)
    }

    private var selectImageButton: some View {
        WideButton(text: "Select Image",
                   action: {
            showMedicationForm = false
            showSelection = true },
                   backgroundColor: .darkpurple)
        .cornerRadius(40)
        .padding(.top)
        .padding(.horizontal, 45)
    }

    private var getMedicationInformationButton: some View {
        WideButton(
            text: "Continue",
            action: {
                guard let selectedImage = selectedImage else { return }
                medicationViewModel.isLoading = true

                Task {
                    await medicationViewModel.analyzeImageAndFetchMedicationInfo(selectedImage)
                    medicationViewModel.isLoading = true
                    if medicationViewModel.medicationInfo != nil {
                        showMedicationForm = true
                    }

                    medicationViewModel.isLoading = false
                }
            },
            backgroundColor: medicationViewModel.isLoading ? .gray : .darkpurple)
        .cornerRadius(40)
        .disabled(medicationViewModel.isLoading)
        .padding(.horizontal, 45)
    }

    private func imagePreview(_ selectedImage: UIImage) -> some View {
        Image(uiImage: selectedImage)
            .resizable()
            .scaledToFit()
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .overlay(
                Button {
                    self.selectedImage = nil
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .padding(5)
                        .background(Color.white.opacity(0.6))
                        .clipShape(Circle())
                        .foregroundStyle(.black)
                }
                    .padding(5)
                    .disabled(medicationViewModel.isLoading),
                alignment: .topTrailing)
    }
}

#Preview {
    ImageUploadView()
        .environmentObject(MedicationViewModel())
}

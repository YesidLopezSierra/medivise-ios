//
//  MedicationPDFView.swift
//  Medivise
//
//  Created by Sara Ortiz Drada on 29.04.24.
//

import SwiftUI

struct MedicationPDFView: View {
    @State private var showingPDF = false
    @StateObject var viewModel = MedicationPDFViewModel()
    let user: User?

    var body: some View {
        ZStack {
            AppColor.darkblue.color
                .edgesIgnoringSafeArea(.top)
            VStack {
                VStack(alignment: .leading, spacing: 15) {
                    Text("Ready for Your Doctor’s Visit?")
                        .font(.title2)
                        .fontWeight(.medium)
                        .padding(.horizontal, 45)
                    Text("Download a detailed PDF of your medications to share with your healthcare provider.")
                        .padding(.horizontal, 45)
                    Image("37")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 150)
                        .frame(maxWidth: .infinity)
                        .padding(.top)

                    WideButton(
                        text: "View PDF",
                        action: {
                            if (user != nil ) {
                                viewModel.getPDF(userId: user!.id!)
                            }
                        },
                        backgroundColor: viewModel.isLoading || user == nil ? .gray : .darkpurple
                    )
                    .cornerRadius(40)
                    .padding(.horizontal, 75)
                    .padding(.vertical, 20)
                    .disabled(viewModel.isLoading || user == nil)
                    .sheet(isPresented: $showingPDF) {
                        if let url = viewModel.pdfURL {
                            PDFViewer(url: url)
                        } else {
                            Text("Unable to load PDF.")
                        }
                    }
                    Spacer()
                }
                .padding(.top, 40)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
                .edgesIgnoringSafeArea(.bottom)
                .shadow(radius: 10)
            }
            .onChange(of: viewModel.pdfURL) {
                if viewModel.pdfURL != nil {
                    showingPDF = true
                }
            }
        }
    }
}

#Preview {
    MedicationPDFView(user: User(age: 1, allergies: [], bloodType: BloodType.aNegative, gender: Gender.female, height: 0.0, medicalConditions: [], name: "  ",weight: 0.0))
        .environmentObject(UserFormViewModel())
}

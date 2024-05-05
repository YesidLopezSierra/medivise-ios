//
//  WelcomeScreenView.swift
//  Medivise
//
//  Created by Sara Ortiz Drada on 07.04.24.
//

import SwiftUI

struct WelcomeScreenView: View {
    @State private var showUserForm = false

    var body: some View {
            ZStack {
                AppColor.darkblue.color
                VStack(spacing: 10) {
                    Text("Your Medication, Simplified")
                        .font(.headline)
                        .multilineTextAlignment(.center)

                    Spacer()
                        .frame(height: 20)
                    VStack(spacing: 30) {
                        Text("**Safely** manage your meds. \nStart **checking interactions** with ease.")
                            .multilineTextAlignment(.center)
                        Divider()
                            .frame(height: 1)
                            .background(.white)
                            .padding(.horizontal, 110)
                    }
                }
                .foregroundStyle(.white)
                .padding(.bottom, 375)
                .padding(.horizontal, 50)

                VStack {
                    Spacer()
                    ZStack {
                        Color.white
                            .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
                            .shadow(radius: 10)
                        Button {
                            showUserForm.toggle()
                        } label: {
                            Text("Get Started")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                                .padding()
                                .background(.darkpurple)
                                .cornerRadius(40)
                                .padding(.horizontal, 75)
                                .shadow(radius: 8)
                        }
                        .padding(.top, 60)
                        .sheet(isPresented: $showUserForm) {
                            UserFormView()
                        }
                    }
                    .edgesIgnoringSafeArea(.bottom)
                    .frame(height: 275)

                }
                Image("pills")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 300)
                    .offset(y: 110)
            }
            .edgesIgnoringSafeArea(.top)
    }
}

#Preview {
    WelcomeScreenView()
        .environmentObject(UserFormViewModel())
}

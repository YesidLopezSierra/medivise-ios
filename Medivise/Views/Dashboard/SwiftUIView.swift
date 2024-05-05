//
//  SwiftUIView.swift
//  Medivise
//
//  Created by Sara Ortiz Drada on 18.04.24.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        VStack {
            ZStack(alignment: .top) {
                AppColor.darkblue.color
                    .edgesIgnoringSafeArea(.all)
                Image("26")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 230)
                    .offset(CGSize(width: 70, height:20))
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Welcome!")
                            .font(.largeTitle)
                            .bold()
                        Text("Safely manage your \nmedications in one \nplace.")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
                .padding(.leading)
            }
        }
    }
}

#Preview {
    SwiftUIView()
}

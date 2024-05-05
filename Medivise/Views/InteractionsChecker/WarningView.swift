//
//  WarningView.swift
//  Medivise
//
//  Created by Sara Ortiz Drada on 29.04.24.
//

import SwiftUI

struct WarningView: View {
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: "exclamationmark.triangle.fill")
                .padding(.top, 15)

            Text("**Warning:** Absence of reported drug interactions is not a confirmation of safety. Always consult with a healthcare professional.")
                .font(.caption)
                .multilineTextAlignment(.leading)
        }
        .foregroundColor(.red)
        .padding()
        .background(.white)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.red, lineWidth: 2)
        )
    }
}

#Preview {
    WarningView()
}

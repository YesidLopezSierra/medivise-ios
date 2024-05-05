//
//  WideButton.swift
//  Medivise
//
//  Created by Sara Ortiz Drada on 27.03.24.
//

import SwiftUI

struct WideButton: View {
    var text: String
    var action: () -> Void
    var backgroundColor: Color = .blue
    var fontColor: Color = .white

    var body: some View {
        Button {
            action()
        } label: {
            Text(text)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .fontWeight(.medium)
                .foregroundColor(fontColor)
                .padding()
                .background(backgroundColor)
                .cornerRadius(10)
        }
    }
}

#Preview {
    WideButton(text: "Button Text", action: {})
}

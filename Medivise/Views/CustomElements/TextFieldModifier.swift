//
//  TextFieldModifier.swift
//  Medivise
//
//  Created by Sara Ortiz Drada on 26.03.24.
//

import SwiftUI

struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .padding(.horizontal)
            .padding(.vertical, 12)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 0.6))
            .lineLimit(5)
    }
}

extension View {
    func customTextField() -> some View {
        modifier(TextFieldModifier())
    }
}

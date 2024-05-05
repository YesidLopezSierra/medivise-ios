//
//  WavyLineView.swift
//  Medivise
//
//  Created by Sara Ortiz Drada on 28.04.24.
//

import SwiftUI

struct WavyLineView: View {
    var amplitude: CGFloat = 10
    var wavelength: CGFloat = 100

    var body: some View {
        // Drawing a path that represents a wavy line
        Path { path in
            // Start at the left edge
            path.move(to: CGPoint(x: 0, y: amplitude))

            // Draw the sine wave across the width of the view
            for x in stride(from: 0, through: UIScreen.main.bounds.width, by: 1) {
                let relativeX = x / wavelength
                let sineValue = sin(relativeX * 2 * .pi)
                let y = amplitude * sineValue + amplitude
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        .stroke(.black, lineWidth: 2) // Set the color and line width of the wavy line
        .frame(height: amplitude * 2) // Set the frame height to twice the amplitude to contain the wave
    }
}

#Preview {
    WavyLineView()
}

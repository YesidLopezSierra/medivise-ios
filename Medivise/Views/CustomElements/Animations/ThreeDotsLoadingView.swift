//
//  ThreeDotsLoadingView.swift
//  Medivise
//
//  Created by Sara Ortiz Drada on 19.04.24.
//

import SwiftUI

struct ThreeDotsLoadingView: View {
    @State private var activeDot = 0
    let dotCount = 3
    let animationDuration: TimeInterval = 0.5
    let dotSize: CGFloat = 12
    let activeDotSize: CGFloat = 18

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<dotCount, id: \.self) { index in
                Circle()
                    .frame(width: index == activeDot ? activeDotSize : dotSize,
                           height: index == activeDot ? activeDotSize : dotSize)
                    .foregroundColor(.blue)
                    .opacity(index == activeDot ? 1.0 : 0.5)
                    .scaleEffect(index == activeDot ? 1.3 : 1)
                    .animation(Animation.easeOut(duration: animationDuration).repeatForever(autoreverses: true), value: activeDot)
            }
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: animationDuration, repeats: true) { _ in
                withAnimation {
                    activeDot = (activeDot + 1) % dotCount
                }
            }
        }
    }
}

struct DotView: View {
    var color: Color = .blue
    var size: CGFloat = 16

    var upMovement: CGFloat
    var scale: CGFloat

    var body: some View {
        Circle()
            .fill(color)
            .frame(width: size, height: size)
            .scaleEffect(scale)
            .offset(y: upMovement)
    }
}

struct WaveLoadingView: View {
    @State private var animate = false
    private var purple: Color = .darkpurple
    private var blue: Color = .lightblue

    private var colors: [Color] {
        [purple.opacity(0.33), purple.opacity(0.66), purple]
    }

    private var colorsOpacity: [Color] {
        [blue.opacity(0.33), blue.opacity(0.66), blue]
    }

    let animationDuration: Double = 0.6
    let animationDelay: Double = 0.2
    let dotSize: CGFloat = 10
    let movementRange: CGFloat = 30

    var body: some View {
        HStack(spacing: 15) {
            ForEach(0..<3) { index in
                DotView(color: animate ? colors[index] : colorsOpacity[index], size: dotSize, upMovement: animate ? -movementRange : 0, scale: animate ? 1.2 : 1)
                    .animation(
                        Animation.easeInOut(duration: animationDuration)
                            .repeatForever(autoreverses: true)
                            .delay(Double(index) * animationDelay),
                        value: animate
                    )
            }
        }
        .onAppear {
            animate = true
        }
    }
}

#Preview {
    WaveLoadingView()
}

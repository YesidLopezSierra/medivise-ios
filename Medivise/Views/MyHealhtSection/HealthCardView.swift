//
//  HealthCardView.swift
//  Medivise
//
//  Created by Sara Ortiz Drada on 18.04.24.
//

import SwiftUI
struct HealthCardView: View {
    var title: String
    var icon: String
    var measurement: String
    var unit: String
    var amplitude: CGFloat = 10
    var wavelength: CGFloat = 100

    var body: some View {
        ZStack {
            VStack {
                HStack(spacing: 10) {
                    ZStack {
                        Circle()
                            .foregroundStyle(.darkpurple)
                            .frame(width: 40, height: 40)
                        Image(systemName: icon)
                            .foregroundColor(.white)
                    }
                    Text(title)
                        .font(.headline)
                    Spacer()
                }
                Spacer()
                HStack(alignment: .bottom, spacing: 5) {
                    Text(measurement)
                        .font(.title)
                    Text(unit)
                        .font(.title3)
                        .foregroundStyle(.gray)
                        .padding(.bottom, 2)
                    Spacer()
                }
            }
            .padding()
            .background(.white)

            WavyLineView(amplitude: amplitude, wavelength: wavelength)
                .frame(height: 200)
        }
        .frame(width: 230, height: 200)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 5)
    }
}

#Preview {
    HealthCardView(title: "Weight", icon: "arrow", measurement: "65", unit: "kg")
}

#Preview {
    return ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 15) {
            HealthCardView(title: "Weight", icon: "heart.fill", measurement: "66", unit: "kg")
            HealthCardView(title: "Heigth", icon: "waveform.path.ecg", measurement: "72", unit: "BPM")
        }
        .padding()
    }
}

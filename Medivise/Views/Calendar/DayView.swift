//
//  DayView.swift
//  Medivise
//
//  Created by Sara Ortiz Drada on 26.03.24.
//

import SwiftUI

struct DayView: View {
    var date: Date
    var isSelected: Bool

    private var dayFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter
    }

    private var numberFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter
    }

    var body: some View {
        VStack {
            Text(dayFormatter.string(from: date))
                .font(.caption)
            Text(numberFormatter.string(from: date))
                .font(.body)
                .frame(width: 30, height: 30)
                .background(Circle().fill(isSelected ? Color.blue : Color.clear))
                .overlay(Circle().stroke(Color.gray, lineWidth: isSelected ? 0 : 1))
                .foregroundColor(isSelected ? .white : .black)
        }
        .padding(.bottom, 3)
    }
}
#Preview {
    DayView(date: Date(), isSelected: true)
}

//
//  CalendarView.swift
//  Medivise
//
//  Created by Sara Ortiz Drada on 26.03.24.
//

import SwiftUI

struct CalendarView: View {
        @State private var selectedDate = Date()
        private let calendar = Calendar.current
        private let today = Date()
        private let daysBeforeToday = 30
        private let daysAfterToday = 30

        private var days: [Date] {
            let range = (-daysBeforeToday...daysAfterToday)
            return range.compactMap { calendar.date(byAdding: .day, value: $0, to: today) }
        }

        private func isToday(date: Date) -> Bool {
            return calendar.isDateInToday(date)
        }

        var body: some View {
            VStack {
                HStack {
                    Text("Medications")
                        .font(.title)
                        .bold()
                }
                .padding(.bottom)

                ScrollViewReader { value in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 25) {
                            ForEach(days, id: \.self) { date in
                                DayView(date: date, isSelected: calendar.isDate(date, inSameDayAs: selectedDate))
                                    .id(date)
                                    .onTapGesture {
                                        withAnimation {
                                            selectedDate = date
                                            value.scrollTo(selectedDate, anchor: .center)
                                        }
                                    }
                            }
                        }
                        .onAppear {
                            DispatchQueue.main.async {
                                withAnimation {
                                    value.scrollTo(today, anchor: .center)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }

#Preview {
    CalendarView()
}

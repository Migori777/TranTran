//
//  WeekStrip.swift
//  TranTran
//
//  Created by Andrea Migori on 08/10/2026.
//

import SwiftUI

struct WeekStrip: View {
    let today: Date
    @Binding var selectedDate: Date
    private let initials = ["L", "M", "M", "G", "V", "S", "D"]
    private var monday: Date {
        let weekday = Calendar.current.component(.weekday, from: today)
        let daysBack = (weekday + 5) % 7
        return Calendar.current.date(byAdding: .day, value: -daysBack, to: today) ?? today
    }
    
    private func date(at index: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: index, to: monday) ?? monday
    }
    
    var body: some View {
        HStack(spacing: 6) {
            ForEach(0..<7) { index in
                Button {
                    selectedDate = date(at: index)
                } label: {
                    DayCell(letter: initials[index],
                            number: Calendar.current.component(.day, from: date(at: index)),
                            isSelected: Calendar.current.isDate(date(at: index), inSameDayAs: selectedDate),
                            isToday: Calendar.current.isDate(date(at: index), inSameDayAs: today))
                }
                .buttonStyle(.plain)
            }
        }
        .fontDesign(.rounded)
    }
}

struct DayCell: View {
    let letter: String
    let number: Int
    let isSelected: Bool
    let isToday: Bool

    private var numberColor: Color {
        if isSelected {
            return Color(.onAccent)
        } else if isToday && !isSelected {
            return Color.accentColor
        }
        return Color(.textPrimary)
    }
    
    var body: some View {
        VStack(spacing: 1) {
            Text(letter)
                .font(.caption)
                .fontWeight(.heavy)
                .foregroundStyle(isSelected ? Color(.onAccent) : Color(.textSecondary))
            Text("\(number)")
                .font(.body)
                .fontWeight(.black)
                .foregroundStyle(numberColor)
        }
        .frame(maxWidth: .infinity, minHeight: 58)
        .background(isSelected ? Color.accentColor : Color(.surface))
        .clipShape(.rect(cornerRadius: 18))
    }
}

#Preview {
    ZStack {
        Color(.appBackground)
            .ignoresSafeArea()
        WeekStrip(today: Date.now, selectedDate: .constant(Date.now))
            .padding(.horizontal, 20)
    }
}

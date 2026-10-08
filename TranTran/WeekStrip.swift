//
//  WeekStrip.swift
//  TranTran
//
//  Created by Andrea Migori on 08/10/2026.
//

import SwiftUI

struct WeekStrip: View {
    private let initials = ["L", "M", "M", "G", "V", "S", "D"]
    var body: some View {
        HStack(spacing: 6) {
            ForEach(0..<7) { index in
                DayCell(letter: initials[index], number: 5 + index, isSelected: index == 0)
            }
        }
        .fontDesign(.rounded)
    }
}

struct DayCell: View {
    let letter: String
    let number: Int
    let isSelected: Bool
    
    var body: some View {
        VStack(spacing: 1) {
            Text(letter)
                .font(.caption)
                .fontWeight(.heavy)
                .foregroundStyle(isSelected ? Color(.onAccent) : Color(.textSecondary))
            Text("\(number)")
                .font(.body)
                .fontWeight(.black)
                .foregroundStyle(isSelected ? Color(.onAccent) : Color(.textPrimary))
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
        WeekStrip()
            .padding(.horizontal, 20)
    }
}

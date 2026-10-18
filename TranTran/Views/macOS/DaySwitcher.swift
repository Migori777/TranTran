//
//  DaySwitcher.swift
//  TranTran
//
//  Created by Andrea Migori on 15/10/2026.
//

import SwiftUI

struct DaySwitcher: View {
    @Binding var selectedDate: Date
    
    private var isToday: Bool {
        Calendar.current.isDate(selectedDate, inSameDayAs: .now)
    }
    
    private func move(by days: Int) {
        selectedDate = Calendar.current.date(byAdding: .day, value: days, to: selectedDate) ?? selectedDate
    }
    
    var body: some View {
        HStack(spacing: 2) {
            Button {
                move(by: -1)
            } label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 11))
                    .fontWeight(.heavy)
                    .frame(width: 36, height: 34)
                    .contentShape(.capsule)
            }
            .buttonStyle(.plain)
            .accessibilityLabel("Giorno precedente")
            
            Button {
                selectedDate = .now
            } label: {
                Text("Oggi")
                    .font(.system(size: 14))
                    .fontWeight(isToday ? .heavy : .black)
                    .foregroundStyle(isToday ? Color(.textPrimary) : Color.accentColor)
                    .padding(.horizontal, 12)
                    .frame(height: 34)
                    .contentShape(.capsule)
            }
            .buttonStyle(.plain)
            
            Button {
                move(by: 1)
            } label: {
                Image(systemName: "chevron.right")
                    .font(.system(size: 11))
                    .fontWeight(.heavy)
                    .frame(width: 36, height: 34)
                    .contentShape(.capsule)
            }
            .buttonStyle(.plain)
            .accessibilityLabel("Giorno successivo")
        }
        .padding(3)
        .glassEffect()
    }
}

#Preview {
    @Previewable @State var selectedDate = Date.now
    DaySwitcher(selectedDate: $selectedDate)
        .padding(20)
        .background(Color(.appBackground))
        .foregroundStyle(Color(.textPrimary))
        .fontDesign(.rounded)
}

//
//  TabBar.swift
//  TranTran
//
//  Created by Andrea Migori on 08/10/2026.
//

import SwiftUI

struct TabBar: View {
    @Binding var selection: AppSection
    
    var body: some View {
        HStack(spacing: 0) {
            Button {
                selection = .today
            } label: {
                BarItem(title: "Oggi", symbol: "calendar", isSelected: selection == .today)
            }
            .buttonStyle(.plain)
            Button {
                selection = .routine
            } label: {
                BarItem(title: "Routine", symbol: "repeat", isSelected: selection == .routine)
            }
            .buttonStyle(.plain)
            Button {
                selection = .balance
            } label: {
                BarItem(title: "Bilancio", symbol: "chart.bar", isSelected: selection == .balance)
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 4)
        .frame(height: 60)
        .glassEffect()
        .fontDesign(.rounded)
    }
}

struct BarItem: View {
    let title: String
    let symbol: String
    let isSelected: Bool
    
    var body: some View {
        VStack(spacing: 2) {
            Image(systemName: symbol)
                .font(.body)
                .fontWeight(.semibold)
            Text(title)
                .font(.caption2)
                .fontWeight(isSelected ? .black : .heavy)
        }
        .foregroundStyle(isSelected ? Color.accentColor : Color(.textSecondary))
        .frame(maxWidth: .infinity, minHeight: 52)
        .background(isSelected ? Color(.textPrimary).opacity(0.08) : Color.clear)
        .clipShape(.capsule)
        .contentShape(.capsule)
    }
}

#Preview {
    @Previewable @State var selection = AppSection.today
    ZStack(alignment: .bottom) {
        Color(.appBackground)
            .ignoresSafeArea()
        TabBar(selection: $selection)
            .padding(.horizontal, 20)
    }
}

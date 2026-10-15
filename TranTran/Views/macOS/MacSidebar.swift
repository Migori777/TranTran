//
//  MacSidebar.swift
//  TranTran
//
//  Created by Andrea Migori on 15/10/2026.
//

import SwiftUI

struct MacSidebarItem: View {
    let title: String
    let symbol: String
    let isSelected: Bool
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: symbol)
                .font(.system(size: 14))
                .fontWeight(.bold)
                .foregroundStyle(isSelected ? Color.accentColor : Color(.textSecondary))
                .frame(width: 18)
            Text(title)
                .font(.system(size: 15))
                .fontWeight(isSelected ? .heavy : .bold)
        }
        .padding(.horizontal, 12)
        .frame(maxWidth: .infinity, minHeight: 38, alignment: .leading)
        .background(isSelected ? Color(.textPrimary).opacity(0.07) : Color.clear)
        .clipShape(.rect(cornerRadius: 12))
        .contentShape(.rect(cornerRadius: 12))
    }
}

struct MacSidebar: View {
    @Binding var selection: AppSection
    
    var body: some View {
        VStack(spacing: 4) {
            Button {
                selection = .today
            } label: {
                MacSidebarItem(title: "Oggi", symbol: "calendar", isSelected: selection == .today)
            }
            .buttonStyle(.plain)
            
            Button {
                selection = .routine
            } label: {
                MacSidebarItem(title: "Routine", symbol: "repeat", isSelected: selection == .routine)
            }
            .buttonStyle(.plain)
            
            Button {
                selection = .balance
            } label: {
                MacSidebarItem(title: "Bilancio", symbol: "chart.bar", isSelected: selection == .balance)
            }
            .buttonStyle(.plain)
            
            Spacer()
            StreakCard(days: 4)
        }
        .padding(.top, 44)
        .padding(.horizontal, 10)
        .padding(.bottom, 10)
        .frame(width: 220)
        .frame(maxHeight: .infinity)
        .glassEffect(.regular, in: .rect(cornerRadius: 18))
        .padding(8)
        .foregroundStyle(Color(.textPrimary))
        .fontDesign(.rounded)
    }
}

#Preview {
    @Previewable @State var selection = AppSection.today
    MacSidebar(selection: $selection)
        .frame(height: 600)
        .background(Color(.appBackground))
}

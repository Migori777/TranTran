//
//  TabBar.swift
//  TranTran
//
//  Created by Andrea Migori on 08/10/2026.
//

import SwiftUI

struct TabBar: View {
    @Binding var selection: AppSection
    @Namespace private var barNamespace
    
    var body: some View {
        HStack(spacing: 0) {
            Button {
                selection = .today
            } label: {
                BarItem(title: "Oggi", symbol: "calendar", isSelected: selection == .today, namespace: barNamespace)
            }
            .buttonStyle(.plain)
            Button {
                selection = .routine
            } label: {
                BarItem(title: "Routine", symbol: "repeat", isSelected: selection == .routine, namespace: barNamespace)
            }
            .buttonStyle(.plain)
            Button {
                selection = .balance
            } label: {
                BarItem(title: "Bilancio", symbol: "chart.bar", isSelected: selection == .balance, namespace: barNamespace)
            }
            .buttonStyle(.plain)
        }
        .animation(.snappy, value: selection)
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
    let namespace: Namespace.ID
    
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
        .background {
            if isSelected {
                Capsule()
                    .fill(Color(.textPrimary).opacity(0.08))
                    .matchedGeometryEffect(id: "capsule", in: namespace)
            }
        }
        .contentShape(.capsule)
    }
}

struct AddButton: View {
    var body: some View {
        Button {
        } label: {
            Image(systemName: "plus")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(Color(.onAccent))
                .frame(width: 60, height: 60)
                .contentShape(.circle)
        }
        .buttonStyle(.plain)
        .glassEffect(.regular.tint(Color.accentColor).interactive(), in: .circle)
        .shadow(color: Color.accentColor.opacity(0.34), radius: 13, y: 10)
        .accessibilityLabel("Nuova attività")
    }
}

#Preview {
    @Previewable @State var selection = AppSection.today
    ZStack(alignment: .bottom) {
        Color(.appBackground)
            .ignoresSafeArea()
        HStack(spacing: 10) {
            TabBar(selection: $selection)
            AddButton()
        }
        .padding(.horizontal, 20)        
    }
}

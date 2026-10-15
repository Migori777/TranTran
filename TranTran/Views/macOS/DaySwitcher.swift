//
//  DaySwitcher.swift
//  TranTran
//
//  Created by Andrea Migori on 15/10/2026.
//

import SwiftUI

struct DaySwitcher: View {
    var body: some View {
        HStack(spacing: 2) {
            Button {
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
            } label: {
                Text("Oggi")
                    .font(.system(size: 14))
                    .fontWeight(.heavy)
                    .padding(.horizontal, 12)
                    .frame(height: 34)
                    .contentShape(.capsule)
            }
            .buttonStyle(.plain)
            
            Button {
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
    DaySwitcher()
        .padding(20)
        .background(Color(.appBackground))
        .foregroundStyle(Color(.textPrimary))
        .fontDesign(.rounded)
}

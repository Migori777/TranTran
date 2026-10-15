//
//  StreakPill.swift
//  TranTran
//
//  Created by Andrea Migori on 14/10/2026.
//

import SwiftUI

struct StreakPill: View {
    let days: Int
    
    private var label: String {
        if days == 1 {
            return "Serie di \(days) giorno"
        }
        return "Serie di \(days) giorni"
    }
    
    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: "flame")
                .font(.caption2)
                .fontWeight(.heavy)
                .foregroundStyle(Color(.streakFlame))
            Text(label)
                .font(.footnote)
                .fontWeight(.heavy)
        }
        .padding(.leading, 9)
        .padding(.trailing, 12)
        .frame(height: 30)
        .glassEffect()
    }
}

#Preview {
    ZStack {
        Color(.appBackground)
            .ignoresSafeArea()
        VStack(spacing: 12) {
            StreakPill(days: 4)
            StreakPill(days: 1)
        }
    }
    .foregroundStyle(Color(.textPrimary))
    .fontDesign(.rounded)
}

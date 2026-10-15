//
//  StreakCard.swift
//  TranTran
//
//  Created by Andrea Migori on 15/10/2026.
//

import SwiftUI

struct StreakCard: View {
    let days: Int
    
    private var label: String {
        if days == 1 {
            return "Serie di 1 giorno"
        }
        return "Serie di \(days) giorni"
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack(spacing: 6) {
                Image(systemName: "flame")
                    .font(.system(size: 10))
                    .fontWeight(.heavy)
                    .foregroundStyle(Color(.streakFlame))
                Text(label)
                    .font(.system(size: 15))
                    .fontWeight(.black)
            }
            Text("Non rovinare tutto.")
                .font(.system(size: 13))
                .fontWeight(.bold)
                .foregroundStyle(Color(.textSecondary))
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.textPrimary).opacity(0.05))
        .clipShape(.rect(cornerRadius: 12))
    }
}

#Preview {
    StreakCard(days: 4)
        .padding(10)
        .frame(width: 220)
        .background(Color(.appBackground))
        .foregroundStyle(Color(.textPrimary))
        .fontDesign(.rounded)
}

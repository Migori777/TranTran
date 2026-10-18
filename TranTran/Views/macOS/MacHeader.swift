//
//  MacHeader.swift
//  TranTran
//
//  Created by Andrea Migori on 15/10/2026.
//

import SwiftUI

struct MacHeader: View {
    let dateText: String
    let titleText: String
    let summaryText: String
    @Binding var selectedDate: Date
    @Binding var isAdding: Bool
    
    var body: some View {
        HStack (alignment: .bottom, spacing: 14) {
            VStack(alignment: .leading, spacing: 2) {
                Text(dateText)
                    .font(.system(size: 13))
                    .fontWeight(.heavy)
                    .textCase(.uppercase)
                    .kerning(0.8)
                    .foregroundStyle(Color(.textSecondary))
                Text(titleText)
                    .font(.system(size: 32))
                    .fontWeight(.black)
                    .kerning(-0.3)
                Text(summaryText)
                    .font(.system(size: 15))
                    .fontWeight(.bold)
                    .foregroundStyle(Color(.textSecondary))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            HStack(spacing: 8) {
                DaySwitcher(selectedDate: $selectedDate)
                NewActivityButton(isAdding: $isAdding)
            }
        }
        .padding(.bottom, 2)
    }
}

#Preview {
    MacHeader(dateText: "Giovedì 15 ottobre", titleText: "Quasi venerdì.", summaryText: "1 fatta su 5. Il resto è ottimismo.", selectedDate: .constant(Date.now), isAdding: .constant(false))
        .padding(20)
        .background(Color(.appBackground))
        .foregroundStyle(Color(.textPrimary))
        .fontDesign(.rounded)
}

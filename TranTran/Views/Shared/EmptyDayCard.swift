//
//  EmptyDayCard.swift
//  TranTran
//
//  Created by Andrea Migori on 18/10/2026.
//

import SwiftUI

struct EmptyDayCard: View {
    @Binding var isAdding: Bool
    
    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: "sun.max")
                .font(.system(size: 24))
                .fontWeight(.bold)
                .foregroundStyle(Color.accentColor)
                .frame(width: 64, height: 64)
                .background(Color(.accentSoft))
                .clipShape(.rect(cornerRadius: 22))
                .padding(.bottom, 8)
            Text("Giornata libera.")
                .font(.system(size: 20))
                .fontWeight(.black)
            Text("Nessuna attività. Sospetto, ma bello.")
                .font(.system(size: 14))
                .fontWeight(.bold)
                .foregroundStyle(Color(.textSecondary))
            Button {
                isAdding = true
            } label: {
                HStack(spacing: 6) {
                    Image(systemName: "plus")
                    Text("Aggiungi un'attività")
                }
                .font(.system(size: 15))
                .fontWeight(.heavy)
                .foregroundStyle(Color.accentColor)
                .padding(.leading, 14)
                .padding(.trailing, 18)
                .frame(height: 44)
                .background(Color(.accentSoft))
                .clipShape(.capsule)
                .contentShape(.capsule)
            }
            .buttonStyle(.plain)
            .padding(.top, 12)
        }
        .multilineTextAlignment(.center)
        #if os(macOS)
        .padding(.top, 48)
        .padding(.bottom, 40)
        #else
        .padding(.top, 32)
        .padding(.bottom, 24)
        #endif
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity)
        .background(Color(.surface))
        .clipShape(.rect(cornerRadius: 26))
    }
}

#Preview {
    EmptyDayCard(isAdding: .constant(false))
        .padding(20)
        .background(Color(.appBackground))
        .foregroundStyle(Color(.textPrimary))
        .fontDesign(.rounded)
}

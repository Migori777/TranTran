//
//  NewActivityButton.swift
//  TranTran
//
//  Created by Andrea Migori on 15/10/2026.
//

import SwiftUI

struct NewActivityButton: View {
    @Binding var isAdding: Bool
    
    var body: some View {
        Button {
            isAdding = true
        } label: {
            HStack(spacing: 6) {
                Image(systemName: "plus")
                Text("Nuova attività")
            }
            .font(.title3)
            .fontWeight(.heavy)
            .foregroundStyle(Color(.onAccent))
            .padding(.leading, 12)
            .padding(.trailing, 16)
            .frame(height: 40)
            .contentShape(.capsule)
        }
        .buttonStyle(.plain)
        .glassEffect(.regular.tint(Color.accentColor).interactive(), in: .capsule)
        .shadow(color: Color.accentColor.opacity(0.34), radius: 9, y: 6)
    }
}

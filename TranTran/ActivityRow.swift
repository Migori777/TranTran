//
//  ActivityRow.swift
//  TranTran
//
//  Created by Andrea Migori on 04/10/2026.
//

import SwiftUI

struct ActivityRow: View {
    let activity: Activity
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: activity.symbol)
                .frame(width: 36, height: 36)
                .background(.orange.opacity(0.25))
                .clipShape(.rect(cornerRadius: 12))
            VStack(alignment: .leading, spacing: 2) {
                Text(activity.title)
                    .font(.headline)
                HStack(spacing: 6) {
                    Text(activity.timeText)
                        .fontWeight(.bold)
                    Text(activity.note)
                        .foregroundStyle(.secondary)
                }
                .font(.footnote)
                .lineLimit(1)
            }
            
            Spacer()
            Image(systemName: activity.isDone ? "checkmark.circle.fill" : "circle")
                .font(.title2)
                .foregroundStyle(activity.isDone ? Color.accentColor : Color.secondary)
        }
        .padding(12)
        .background(Color.gray.opacity(0.15))
        .clipShape(.rect(cornerRadius: 20))
    }
}

#Preview {
    ActivityRow(activity: Activity.samples[0])
        .padding()
}

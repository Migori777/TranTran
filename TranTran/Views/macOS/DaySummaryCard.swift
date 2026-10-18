//
//  DaySummaryCard.swift
//  TranTran
//
//  Created by Andrea Migori on 18/10/2026.
//

import SwiftUI

struct DaySummaryCard: View {
    let activities: [Activity]
    
    private var doneCount: Int {
        activities.filter { activity in activity.isDone }.count
    }
    
    private var line: some View {
        Rectangle()
            .fill(Color(.textPrimary).opacity(0.08))
            .frame(height: 1)
    }
    
    private func row(_ label: String, _ value: String) -> some View {
        HStack(spacing: 12) {
            Text(label)
                .fontWeight(.bold)
                .foregroundStyle(Color(.textSecondary))
                .layoutPriority(1)
            Spacer()
            Text(value)
                .fontWeight(.heavy)
        }
        .font(.system(size: 14))
        .lineLimit(1)
        .padding(.vertical, 9)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            VStack(alignment: .leading, spacing: 1) {
                Text("In breve")
                    .font(.system(size: 12))
                    .fontWeight(.heavy)
                    .textCase(.uppercase)
                    .kerning(0.7)
                    .foregroundStyle(Color(.textSecondary))
                Text("\(activities.count) attività")
                    .font(.system(size: 19))
                    .fontWeight(.black)
            }
            
            if let first = activities.first, let last = activities.last {
                VStack(spacing: 0) {
                    line
                    row("Si comincia", "\(first.timeText) · \(first.title)")
                    line
                    row("Si finisce", "\(last.timeText) · \(last.title)")
                    line
                    row("Fatte", "\(doneCount) su \(activities.count)")
                    line
                }
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.surface))
        .clipShape(.rect(cornerRadius: 24))
    }
}

#Preview {
    DaySummaryCard(activities: Activity.samples)
        .padding(20)
        .frame(width: 320)
        .background(Color(.appBackground))
        .foregroundStyle(Color(.textPrimary))
        .fontDesign(.rounded)
}

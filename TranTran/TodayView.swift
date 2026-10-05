//
//  TodayView.swift
//  TranTran
//
//  Created by Andrea Migori on 04/10/2026.
//

import SwiftUI

struct TodayView: View {
    @State private var activities = Activity.samples
    
    private var doneCount: Int {
        activities.filter{ activity in activity.isDone }.count
    }
    
    private var summaryText: String {
        let word = doneCount == 1 ? "fatta" : "fatte"
        if doneCount == activities.count {
            return "Ottimo! Hai completato tutte le attività!"
        }
        return "\(doneCount) \(word) su \(activities.count). Il resto è ottimismo."
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Lunedì 5 ottobre")
                        .font(.footnote)
                        .fontWeight(.heavy)
                        .textCase(.uppercase)
                        .kerning(0.8)
                        .foregroundStyle(Color(.textSecondary))
                    Text("Coraggio è lunedì.")
                        .font(.title)
                        .fontWeight(.black)
                    Text(summaryText)
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundStyle(Color(.textSecondary))
                }
                
                VStack(spacing: 8) {
                    ForEach($activities) { $activity in
                        ActivityRow(activity: $activity)
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 8)
        }
        .background(Color(.appBackground))
        .foregroundStyle(Color(.textPrimary))
        .fontDesign(.rounded)
    }
}

#Preview {
    TodayView()
}

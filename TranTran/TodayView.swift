//
//  TodayView.swift
//  TranTran
//
//  Created by Andrea Migori on 04/10/2026.
//

import SwiftUI

struct TodayView: View {
    @State private var activities = Activity.samples
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

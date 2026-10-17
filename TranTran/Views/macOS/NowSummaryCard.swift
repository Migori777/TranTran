//
//  NowSummaryCard.swift
//  TranTran
//
//  Created by Andrea Migori on 15/10/2026.
//

import SwiftUI

struct NowSummaryCard: View {
    @Binding var activity: Activity
    let label: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(spacing: 12) {
                Image(systemName: activity.symbol)
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                    .foregroundStyle(Color(.activityInk))
                    .frame(width: 44, height: 44)
                    .background(activity.color.fill)
                    .clipShape(.rect(cornerRadius: 15))
                VStack(alignment: .leading, spacing: 1) {
                    Text(label)
                        .font(.system(size: 12))
                        .fontWeight(.heavy)
                        .textCase(.uppercase)
                        .kerning(0.7)
                        .foregroundStyle(Color(.textSecondary))
                    Text(activity.title)
                        .font(.system(size: 19))
                        .fontWeight(.black)
                }
            }
            
            VStack(spacing: 0) {
                Rectangle()
                    .fill(Color(.textPrimary).opacity(0.08))
                    .frame(height: 1)
                HStack {
                    Text("Quando")
                        .fontWeight(.bold)
                        .foregroundStyle(Color(.textSecondary))
                    Spacer()
                    Text(activity.intervalText)
                        .fontWeight(.heavy)
                }
                .font(.system(size: 14))
                .padding(.vertical, 9)
                Rectangle()
                    .fill(Color(.textPrimary).opacity(0.08))
                    .frame(height: 1)
            }
            
            HStack(spacing: 8) {
                Button {
                    activity.isDone.toggle()
                } label: {
                    Text("Fatto")
                        .font(.system(size: 14))
                        .fontWeight(.heavy)
                        .foregroundStyle(Color(.onAccent))
                        .frame(width: 90, height: 40)
                        .background(Color.accentColor)
                        .clipShape(.rect(cornerRadius: 14))
                }
                .buttonStyle(.plain)

                Button {
                } label: {
                    Text("Rimanda (ancora)")
                        .font(.system(size: 14))
                        .fontWeight(.heavy)
                        .frame(maxWidth: .infinity, minHeight: 40)
                        .background(Color(.textPrimary).opacity(0.08))
                        .clipShape(.rect(cornerRadius: 14))
                }
                .buttonStyle(.plain)
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.surface))
        .clipShape(.rect(cornerRadius: 24))
    }
}

struct DayDoneCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Per oggi è tutto.")
                .font(.system(size: 19))
                .fontWeight(.black)
            Text("Niente in programma. Goditela.")
                .font(.system(size: 14))
                .fontWeight(.bold)
                .foregroundStyle(Color(.textSecondary))
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.surface))
        .clipShape(.rect(cornerRadius: 24))
    }
}

#Preview {
    VStack(spacing: 16) {
        NowSummaryCard(activity: .constant(Activity.samples[1]), label: "In corso")
        NowSummaryCard(activity: .constant(Activity.samples[2]), label: "Prossima")
        DayDoneCard()
    }
    .padding(20)
    .frame(width: 320)
    .background(Color(.appBackground))
    .foregroundStyle(Color(.textPrimary))
    .fontDesign(.rounded)
}

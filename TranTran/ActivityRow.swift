//
//  ActivityRow.swift
//  TranTran
//
//  Created by Andrea Migori on 04/10/2026.
//

import SwiftUI

struct ActivityRow: View {
    @Binding var activity: Activity
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: activity.symbol)
                .fontWeight(.semibold)
                .foregroundStyle(Color(.activityInk))
                .frame(width: 36, height: 36)
                .background(Color(activity.color.fill))
                .clipShape(.rect(cornerRadius: 13))
            VStack(alignment: .leading, spacing: 1) {
                Text(activity.title)
                    .font(.callout)
                    .fontWeight(.heavy)
                HStack(spacing: 6) {
                    Text(activity.timeText)
                        .fontWeight(.bold)
                    Text(activity.note)
                        .fontWeight(.bold)
                        .foregroundStyle(Color(.textSecondary))
                }
                .font(.footnote)
                .lineLimit(1)
            }
            
            Spacer()
            Button{
                activity.isDone.toggle()
            } label: {
                Image(systemName: activity.isDone ? "checkmark.circle.fill" : "circle")
                                .font(.title2)
                                .foregroundStyle(activity.isDone ? Color.accentColor : Color(.ring))
                                .frame(width: 44, height: 44)
                                .contentShape(.rect)
            }
        }
        .padding(.leading, 14)
        .padding(.trailing, 4)
        .frame(minHeight: 58)
        .foregroundStyle(Color(.textPrimary))
        .background(Color(.surface))
        .clipShape(.rect(cornerRadius: 20))
        .fontDesign(.rounded)
        
    }
}

#Preview {
    ZStack {
        Color(.appBackground)
            .ignoresSafeArea()
        VStack(spacing: 8) {
            ActivityRow(activity: .constant(Activity.samples[1]))
            ActivityRow(activity: .constant(Activity.samples[2]))
            ActivityRow(activity: .constant(Activity.samples[3]))
        }
        .padding()
    }
}

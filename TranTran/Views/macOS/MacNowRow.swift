//
//  MacNowRow.swift
//  TranTran
//
//  Created by Andrea Migori on 15/10/2026.
//

import SwiftUI

struct MacNowRow: View {
    @Binding var activity: Activity
    let nowMinutes: Int
    let isSelected: Bool
    
    var body: some View {
        HStack(spacing: 12) {
            Text(activity.timeText)
                .font(.system(size: 14))
                .fontWeight(.black)
                .foregroundStyle(isSelected ? Color.accentColor : Color(.textPrimary))
                .frame(width: 48, alignment: .trailing)
            nowCard
        }
        .fontDesign(.rounded)
    }
    
    private var nowCard: some View {
        HStack(spacing: 14) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Adesso · fino alle \(activity.endTimeText)")
                    .font(.system(size: 12))
                    .fontWeight(.black)
                    .textCase(.uppercase)
                    .kerning(1)
                Text(activity.title)
                    .font(.system(size: 24))
                    .fontWeight(.black)
                Text("\(activity.note) \(activity.remainingText(at: nowMinutes))")
                    .font(.system(size: 14))
                    .fontWeight(.bold)
                    .opacity(0.8)
                progressBar
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Button {
                activity.isDone.toggle()
            } label: {
                HStack(spacing: 8) {
                    Image(systemName: "checkmark")
                        .font(.system(size: 12))
                        .fontWeight(.heavy)
                    Text("Fatto")
                        .font(.system(size: 15))
                        .fontWeight(.heavy)
                }
                .foregroundStyle(.white)
                .padding(.leading, 14)
                .padding(.trailing, 18)
                .frame(height: 44)
                .background(Color(.activityInk))
                .clipShape(.capsule)
            }
            .buttonStyle(.plain)
        }
        .padding(.vertical, 16)
        .padding(.leading, 18)
        .padding(.trailing, 16)
        .foregroundStyle(Color(.activityInk))
        .background(activity.color.fill)
        .clipShape(.rect(cornerRadius: 24))
        .overlay {
            if isSelected {
                RoundedRectangle(cornerRadius: 24)
                    .strokeBorder(Color.accentColor, lineWidth: 2.5)
            }
        }
    }
    
    private var progressBar: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color(.activityInk).opacity(0.16))
                Capsule()
                    .fill(Color(.activityInk))
                    .frame(width: geometry.size.width * activity.progress(at: nowMinutes))
            }
        }
        .frame(height: 8)
        .padding(.top, 4)
    }
}

#Preview {
    MacNowRow(activity: .constant(Activity.samples[1]), nowMinutes: 11 * 60 + 20, isSelected: true)
        .padding(20)
        .frame(width: 640)
        .background(Color(.appBackground))
}

//
//  MacActivityRow.swift
//  TranTran
//
//  Created by Andrea Migori on 15/10/2026.
//

import SwiftUI

struct MacActivityRow: View {
    @Binding var activity: Activity
    let isSelected: Bool
    
    var body: some View {
        HStack(spacing: 12) {
            Text(activity.timeText)
                .font(.system(size: 14))
                .fontWeight(isSelected ? .black : .heavy)
                .foregroundStyle(isSelected ? Color.accentColor : Color(.textSecondary))
                .frame(width: 48, alignment: .trailing)
            if activity.isDone {
                doneCard
            } else {
                todoCard
            }
        }
        .fontDesign(.rounded)
    }
    
    private var todoCard: some View {
        HStack(spacing: 12) {
            Image(systemName: activity.symbol)
                .font(.system(size: 16))
                .fontWeight(.semibold)
                .foregroundStyle(Color(.activityInk))
                .frame(width: 34, height: 34)
                .background(activity.color.fill)
                .clipShape(.rect(cornerRadius: 12))
            Text(activity.title)
                .font(.system(size: 16))
                .fontWeight(.heavy)
                .layoutPriority(1)
            Text(activity.note)
                .font(.system(size: 14))
                .fontWeight(.bold)
                .foregroundStyle(Color(.textSecondary))
                .frame(maxWidth: .infinity, alignment: .leading)
            Button {
                activity.isDone.toggle()
            } label: {
                Image(systemName: "circle")
                    .font(.system(size: 22))
                    .foregroundStyle(Color(.ring))
                    .frame(width: 36, height: 36)
                    .contentShape(.rect)
            }
            .buttonStyle(.plain)
        }
        .lineLimit(1)
        .padding(.leading, 9)
        .padding(.trailing, 8)
        .frame(height: 52)
        .foregroundStyle(Color(.textPrimary))
        .background(Color(.surface))
        .clipShape(.rect(cornerRadius: 18))
        .overlay {
            if isSelected {
                RoundedRectangle(cornerRadius: 18)
                    .strokeBorder(Color.accentColor, lineWidth: 2.5)
            }
        }
    }
    
    private var doneCard: some View {
        HStack(spacing: 12) {
            Text(activity.title)
                .font(.system(size: 16))
                .fontWeight(.heavy)
                .strikethrough()
                .layoutPriority(1)
            Text(activity.note)
                .font(.system(size: 14))
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
            Button {
                activity.isDone.toggle()
            } label: {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 22))
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(Color(.onAccent), Color.accentColor)
                    .frame(width: 36, height: 36)
                    .contentShape(.rect)
            }
            .buttonStyle(.plain)
        }
        .lineLimit(1)
        .padding(.leading, 16)
        .padding(.trailing, 8)
        .frame(height: 48)
        .foregroundStyle(Color(.textSecondary))
        .background(Color(.surfaceMuted))
        .clipShape(.rect(cornerRadius: 16))
        .overlay {
            if isSelected {
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(Color.accentColor, lineWidth: 2.5)
            }
        }
    }
}

#Preview {
    VStack(spacing: 8) {
        MacActivityRow(activity: .constant(Activity.samples[0]), isSelected: false)
        MacActivityRow(activity: .constant(Activity.samples[2]), isSelected: true)
        MacActivityRow(activity: .constant(Activity.samples[3]), isSelected: false)
    }
    .padding(20)
    .frame(width: 640)
    .background(Color(.appBackground))
}

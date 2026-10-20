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
        VStack(alignment: .leading, spacing: 12) {
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
                    if activity.pieces.isEmpty {
                        progressBar
                    }
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
            if !activity.pieces.isEmpty {
                pieceBar
                if nowIndex != nil || nextIndex != nil {
                    piecesPanel
                }
            }
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
    
    private var nowIndex: Int? {
        activity.nowPieceIndex(at: nowMinutes)
    }
    
    private var nextIndex: Int? {
        activity.nextPieceIndex(at: nowMinutes)
    }
    
    private var piecesPanel: some View {
        VStack(spacing: 0) {
            if let index = nowIndex {
                pieceRow(at: index, isNow: true)
            }
            if let index = nextIndex {
                if nowIndex != nil {
                    Rectangle()
                        .fill(Color(.activityInk).opacity(0.10))
                        .frame(height: 1)
                        .padding(.horizontal, 12)
                }
                pieceRow(at: index, isNow: false)
            }
        }
        .background(Color.white.opacity(0.45))
        .clipShape(.rect(cornerRadius: 14))
    }
    
    private func pieceRow(at index: Int, isNow: Bool) -> some View {
        let piece = activity.pieces[index]
        return HStack(spacing: 10) {
            Text(isNow ? "Ora" : "Poi")
                .font(.system(size: 11))
                .fontWeight(.black)
                .textCase(.uppercase)
                .kerning(0.9)
                .fixedSize()
                .frame(minWidth: 30, alignment: .leading)
            Text(piece.timeText)
                .font(.system(size: 13))
                .fontWeight(.heavy)
                .fixedSize()
                .frame(minWidth: 44, alignment: .leading)
            Text(piece.title)
                .font(.system(size: 15))
                .fontWeight(isNow ? .black : .heavy)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)
            Button {
                activity.togglePiece(at: index)
            } label: {
                Circle()
                    .strokeBorder(Color(.activityInk).opacity(isNow ? 1 : 0.45), lineWidth: 2.5)
                    .frame(width: 20, height: 20)
                    .frame(width: 36, height: 36)
                    .contentShape(.rect)
            }
            .buttonStyle(.plain)
            .accessibilityLabel("Segna il pezzo \(piece.title) come fatto")
        }
        .foregroundStyle(Color(.activityInk).opacity(isNow ? 1 : 0.8))
        .padding(.leading, 12)
        .padding(.trailing, 4)
        .frame(height: 40)
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
    
    private var pieceBar: some View {
        GeometryReader { geometry in
            let barWidth = geometry.size.width - CGFloat(activity.pieces.count - 1) * 3
            HStack(spacing: 3) {
                ForEach(activity.pieces.indices, id: \.self) { index in
                    let segment = barWidth * activity.pieceShare(at: index)
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .fill(Color(.activityInk).opacity(0.16))
                        Rectangle()
                            .fill(Color(.activityInk))
                            .frame(width: segment * activity.pieceProgress(at: index, minutes: nowMinutes))
                    }
                    .frame(width: segment)
                    .clipShape(.capsule)
                }
            }
        }
        .frame(height: 8)
    }
}

#Preview("Con i pezzi") {
    MacNowRow(activity: .constant(Activity.samples[1]), nowMinutes: 10 * 60 + 10, isSelected: false)
        .padding(20)
        .frame(width: 640)
        .background(Color(.appBackground))
}

#Preview("Senza pezzi") {
    MacNowRow(activity: .constant(Activity.samples[2]), nowMinutes: 13 * 60 + 20, isSelected: true)
        .padding(20)
        .frame(width: 640)
        .background(Color(.appBackground))
}

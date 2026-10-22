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
    let nowMinutes: Int
    
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
            
            if !activity.pieces.isEmpty {
                piecesSection
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
    
    private var nowIndex: Int? {
        activity.nowPieceIndex(at: nowMinutes)
    }
    
    private var doneCount: Int {
        activity.pieces.filter { piece in piece.isDone }.count
    }
    
    private var piecesSection: some View {
        VStack(spacing: 4) {
            HStack {
                Text("Pezzi")
                    .fontWeight(.bold)
                    .foregroundStyle(Color(.textSecondary))
                Spacer()
                Text("\(doneCount) di \(activity.pieces.count)")
                    .fontWeight(.heavy)
            }
            .font(.system(size: 14))
            VStack(spacing: 0) {
                ForEach(activity.pieces.indices, id: \.self) { index in
                    pieceRow(at: index)
                }
            }
        }
    }
    
    private func pieceRow(at index: Int) -> some View {
        let piece = activity.pieces[index]
        let isNow = index == nowIndex
        return HStack(spacing: 10) {
            Text(piece.timeText)
                .font(.system(size: 13))
                .fontWeight(isNow ? .black : .heavy)
                .foregroundStyle(isNow ? Color(.textPrimary) : Color(.textSecondary))
                .fixedSize()
                .frame(minWidth: 44, alignment: .leading)
            Text(piece.title)
                .font(.system(size: 14))
                .fontWeight(isNow ? .black : .heavy)
                .strikethrough(piece.isDone)
                .foregroundStyle(piece.isDone ? Color(.textSecondary) : Color(.textPrimary))
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)
            if isNow {
                Text("Ora")
                    .font(.system(size: 11))
                    .fontWeight(.black)
                    .textCase(.uppercase)
                    .kerning(0.9)
                    .foregroundStyle(Color.accentColor)
            }
            Button {
                activity.togglePiece(at: index)
            } label: {
                ZStack {
                    if piece.isDone {
                        Circle()
                            .fill(Color.accentColor)
                        Image(systemName: "checkmark")
                            .font(.system(size: 8))
                            .fontWeight(.heavy)
                            .foregroundStyle(Color(.onAccent))
                    } else {
                        Circle()
                            .strokeBorder(Color(.ring), lineWidth: 2.5)
                    }
                }
                .frame(width: 18, height: 18)
                .frame(width: 28, height: 28)
                .contentShape(.rect)
            }
            .buttonStyle(.plain)
            .accessibilityLabel(piece.isDone ? "Pezzo \(piece.title): fatto. Clicca per annullare" : "Segna il pezzo \(piece.title) come fatto")
        }
        .frame(height: 34)
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
    @Previewable @State var work = Activity.samples[1]
    VStack(spacing: 16) {
        NowSummaryCard(activity: $work, label: "In corso", nowMinutes: 10 * 60 + 10)
        NowSummaryCard(activity: .constant(Activity.samples[2]), label: "Prossima", nowMinutes: 10 * 60 + 10)
        DayDoneCard()
    }
    .padding(20)
    .frame(width: 320)
    .background(Color(.appBackground))
    .foregroundStyle(Color(.textPrimary))
    .fontDesign(.rounded)
}

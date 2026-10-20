//
//  NowCard.swift
//  TranTran
//
//  Created by Andrea Migori on 07/10/2026.
//

import SwiftUI

struct NowCard: View {
    @Binding var activity: Activity
    let nowMinutes: Int
    @State private var isShowingAllPieces = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Adesso · \(activity.intervalText)")
                        .font(.caption)
                        .fontWeight(.black)
                        .textCase(.uppercase)
                        .kerning(1)
                    Text(activity.title)
                        .font(.title2)
                        .fontWeight(.black)
                    Text("\(activity.note) \(activity.remainingText(at: nowMinutes))")
                        .font(.footnote)
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
                    Image(systemName: "checkmark")
                        .font(.body)
                        .fontWeight(.heavy)
                        .foregroundStyle(.white)
                        .frame(width: 56, height: 56)
                        .background(Color(.activityInk))
                        .clipShape(.circle)
                }
                .buttonStyle(.plain)
            }
            if !activity.pieces.isEmpty {
                pieceBar
                piecesPanel
            }
        }
        .padding(.top, 16)
        .padding(.bottom, activity.pieces.isEmpty ? 16 : 14)
        .padding(.leading, 18)
        .padding(.trailing, 14)
        .frame(minHeight: 120)
        .foregroundStyle(Color(.activityInk))
        .background(activity.color.fill)
        .clipShape(.rect(cornerRadius: 26))
        .fontDesign(.rounded)
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
    
    private var nowIndex: Int? {
        activity.nowPieceIndex(at: nowMinutes)
    }
    
    private var nextIndex: Int? {
        activity.nextPieceIndex(at: nowMinutes)
    }
    
    private var shownIndices: [Int] {
        if isShowingAllPieces {
            return Array(activity.pieces.indices)
        }
        return [nowIndex, nextIndex].compactMap { index in index }
    }
    
    private var piecesPanel: some View {
        VStack(spacing: 0) {
            ForEach(shownIndices, id: \.self) { index in
                if index != shownIndices.first {
                    panelLine
                }
                pieceRow(at: index)
            }
            if shownIndices.count < activity.pieces.count || isShowingAllPieces {
                if !shownIndices.isEmpty {
                    panelLine
                }
                showAllButton
            }
        }
        .background(Color.white.opacity(0.45))
        .clipShape(.rect(cornerRadius: 16))
    }
    
    private var panelLine: some View {
        Rectangle()
            .fill(Color(.activityInk).opacity(0.10))
            .frame(height: 1)
            .padding(.horizontal, 12)
    }
    
    private var showAllButton: some View {
        Button {
            withAnimation(.snappy) {
                isShowingAllPieces.toggle()
            }
        } label: {
            HStack {
                Text(isShowingAllPieces ? "Mostra meno" : "Mostra tutti e \(activity.pieces.count)")
                    .font(.footnote)
                    .fontWeight(.black)
                Spacer()
                Image(systemName: isShowingAllPieces ? "chevron.up" : "chevron.down")
                    .font(.footnote)
                    .fontWeight(.heavy)
                    .frame(width: 16)
            }
            .padding(.leading, 12)
            .padding(.trailing, 14)
            .frame(height: 40)
            .contentShape(.rect)
        }
        .buttonStyle(.plain)
        .foregroundStyle(Color(.activityInk).opacity(0.8))
    }
    
    private func label(for index: Int) -> String {
        if index == nowIndex {
            return "Ora"
        }
        if index == nextIndex {
            return "Poi"
        }
        return ""
    }
    
    private func pieceRow(at index: Int) -> some View {
        let piece = activity.pieces[index]
        let isNow = index == nowIndex
        return HStack(spacing: 10) {
            Text(label(for: index))
                .font(.caption2)
                .fontWeight(.black)
                .textCase(.uppercase)
                .kerning(0.9)
                .fixedSize()
                .frame(minWidth: 30, alignment: .leading)
            Text(piece.timeText)
                .font(.footnote)
                .fontWeight(.heavy)
                .fixedSize()
                .frame(minWidth: 44, alignment: .leading)
            Text(piece.title)
                .font(.subheadline)
                .fontWeight(isNow ? .black : .heavy)
                .strikethrough(piece.isDone)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)
            Button {
                activity.togglePiece(at: index)
            } label: {
                ZStack {
                    if piece.isDone {
                        Circle()
                            .fill(Color(.activityInk))
                        Image(systemName: "checkmark")
                            .font(.system(size: 10))
                            .fontWeight(.heavy)
                            .foregroundStyle(.white)
                    } else {
                        Circle()
                            .strokeBorder(Color(.activityInk).opacity(isNow ? 1 : 0.45), lineWidth: 2.5)
                    }
                }
                .frame(width: 22, height: 22)
                .frame(width: 44, height: 44)
                .contentShape(.rect)
            }
            .buttonStyle(.plain)
            .accessibilityLabel(piece.isDone ? "Pezzo \(piece.title): fatto. Tocca per annullare" : "Segna il pezzo \(piece.title) come fatto")
        }
        .foregroundStyle(Color(.activityInk).opacity(isNow ? 1 : 0.8))
        .padding(.leading, 12)
        .frame(height: 44)
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
    ZStack {
        Color(.appBackground)
            .ignoresSafeArea()
        NowCard(activity: .constant(Activity.samples[1]), nowMinutes: 10 * 60 + 10)
            .padding()
    }
}

#Preview("Senza pezzi") {
    ZStack {
        Color(.appBackground)
            .ignoresSafeArea()
        NowCard(activity: .constant(Activity.samples[2]), nowMinutes: 13 * 60 + 20)
            .padding()
    }
}

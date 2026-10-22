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
    @State private var isShowingPieces = false

    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 12) {
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

    private var piecesText: String {
        if activity.pieces.count == 1 {
            return "1 pezzo"
        }
        return "\(activity.pieces.count) pezzi"
    }

    private var todoCard: some View {
        VStack(spacing: 0) {
            HStack(spacing: 12) {
                Image(systemName: activity.symbol)
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
                    .foregroundStyle(Color(.activityInk))
                    .frame(width: 34, height: 34)
                    .background(activity.color.fill)
                    .clipShape(.rect(cornerRadius: 12))
                Text(activity.title.isEmpty ? "Nuova attività" : activity.title)
                    .font(.system(size: 16))
                    .fontWeight(.heavy)
                    .foregroundStyle(activity.title.isEmpty ? Color(.textSecondary) : Color(.textPrimary))
                    .layoutPriority(1)
                if !activity.pieces.isEmpty {
                    Text(piecesText)
                        .font(.system(size: 12))
                        .fontWeight(.black)
                        .foregroundStyle(Color.accentColor)
                        .padding(.horizontal, 8)
                        .frame(height: 20)
                        .background(Color(.accentSoft))
                        .clipShape(.capsule)
                        .fixedSize()
                }
                Text(activity.note)
                    .font(.system(size: 14))
                    .fontWeight(.bold)
                    .foregroundStyle(Color(.textSecondary))
                    .frame(maxWidth: .infinity, alignment: .leading)
                if !activity.pieces.isEmpty {
                    Button {
                        withAnimation(.snappy) {
                            isShowingPieces.toggle()
                        }
                    } label: {
                        Image(systemName: isShowingPieces ? "chevron.up" : "chevron.down")
                            .font(.system(size: 11))
                            .fontWeight(.heavy)
                            .foregroundStyle(Color(.textSecondary))
                            .frame(width: 36, height: 36)
                            .contentShape(.rect)
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel(isShowingPieces ? "Nascondi i pezzi" : "Mostra i pezzi")
                }
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
            .frame(height: 52)
            if isShowingPieces {
                ForEach(activity.pieces.indices, id: \.self) { index in
                    pieceLine
                    pieceRow(at: index)
                }
            }
        }
        .lineLimit(1)
        .padding(.leading, 9)
        .padding(.trailing, 8)
        .padding(.bottom, isShowingPieces ? 6 : 0)
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

    private var pieceLine: some View {
        Rectangle()
            .fill(Color(.textPrimary).opacity(0.08))
            .frame(height: 1)
            .padding(.leading, 46)
            .padding(.trailing, 8)
    }

    private func pieceRow(at index: Int) -> some View {
        let piece = activity.pieces[index]
        return HStack(spacing: 12) {
            Text(piece.timeText)
                .font(.system(size: 13))
                .fontWeight(.heavy)
                .foregroundStyle(Color(.textSecondary))
                .fixedSize()
                .frame(minWidth: 44, alignment: .leading)
            Text(piece.title)
                .font(.system(size: 14))
                .fontWeight(.heavy)
                .strikethrough(piece.isDone)
                .foregroundStyle(piece.isDone ? Color(.textSecondary) : Color(.textPrimary))
                .frame(maxWidth: .infinity, alignment: .leading)
            Button {
                activity.togglePiece(at: index)
            } label: {
                ZStack {
                    if piece.isDone {
                        Circle()
                            .fill(Color.accentColor)
                        Image(systemName: "checkmark")
                            .font(.system(size: 9))
                            .fontWeight(.heavy)
                            .foregroundStyle(Color(.onAccent))
                    } else {
                        Circle()
                            .strokeBorder(Color(.ring), lineWidth: 2.5)
                    }
                }
                .frame(width: 20, height: 20)
                .frame(width: 36, height: 36)
                .contentShape(.rect)
            }
            .buttonStyle(.plain)
            .accessibilityLabel(piece.isDone ? "Pezzo \(piece.title): fatto. Clicca per annullare" : "Segna il pezzo \(piece.title) come fatto")
        }
        .padding(.leading, 46)
        .frame(height: 36)
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
    @Previewable @State var gym = Activity.samples[3]
    VStack(spacing: 8) {
        MacActivityRow(activity: .constant(Activity.samples[0]), isSelected: false)
        MacActivityRow(activity: .constant(Activity.samples[2]), isSelected: true)
        MacActivityRow(activity: $gym, isSelected: false)
    }
    .padding(20)
    .frame(width: 640)
    .background(Color(.appBackground))
}

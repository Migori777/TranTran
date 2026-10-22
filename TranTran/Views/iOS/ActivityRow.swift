//
//  ActivityRow.swift
//  TranTran
//
//  Created by Andrea Migori on 04/10/2026.
//

import SwiftUI

struct ActivityRow: View {
    @Binding var activity: Activity
    @State private var isShowingPieces = false

    var body: some View {
        if activity.isDone {
            doneRow
        } else {
            todoRow
        }
    }

    private var piecesText: String {
        if activity.pieces.count == 1 {
            return "1 pezzo"
        }
        return "\(activity.pieces.count) pezzi"
    }

    private var todoRow: some View {
        VStack(spacing: 0) {
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
                            .fixedSize()
                        if !activity.pieces.isEmpty {
                            Text(piecesText)
                                .font(.caption)
                                .fontWeight(.black)
                                .foregroundStyle(Color.accentColor)
                                .padding(.horizontal, 6)
                                .frame(height: 18)
                                .background(Color(.accentSoft))
                                .clipShape(.capsule)
                                .fixedSize()
                        }
                        Text(activity.note)
                            .fontWeight(.bold)
                            .foregroundStyle(Color(.textSecondary))
                    }
                    .font(.footnote)
                    .lineLimit(1)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                if !activity.pieces.isEmpty {
                    Button {
                        withAnimation(.snappy) {
                            isShowingPieces.toggle()
                        }
                    } label: {
                        Image(systemName: isShowingPieces ? "chevron.up" : "chevron.down")
                            .font(.caption)
                            .fontWeight(.heavy)
                            .foregroundStyle(Color(.textSecondary))
                            .frame(width: 44, height: 44)
                            .contentShape(.rect)
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel(isShowingPieces ? "Nascondi i pezzi" : "Mostra i pezzi")
                }
                Button{
                    activity.isDone.toggle()
                } label: {
                    Image(systemName: "circle")
                        .font(.title2)
                        .foregroundStyle(Color(.ring))
                        .frame(width: 44, height: 44)
                        .contentShape(.rect)
                }
                .buttonStyle(.plain)
            }
            .frame(minHeight: 58)
            if isShowingPieces {
                ForEach(activity.pieces.indices, id: \.self) { index in
                    pieceLine
                    pieceRow(at: index)
                }
            }
        }
        .padding(.leading, 14)
        .padding(.trailing, 4)
        .padding(.bottom, isShowingPieces ? 6 : 0)
        .foregroundStyle(Color(.textPrimary))
        .background(Color(.surface))
        .clipShape(.rect(cornerRadius: 20))
        .fontDesign(.rounded)

    }

    private var pieceLine: some View {
        Rectangle()
            .fill(Color(.textPrimary).opacity(0.08))
            .frame(height: 1)
            .padding(.leading, 46)
            .padding(.trailing, 12)
    }

    private func pieceRow(at index: Int) -> some View {
        let piece = activity.pieces[index]
        return HStack(spacing: 10) {
            Text(piece.timeText)
                .font(.footnote)
                .fontWeight(.heavy)
                .foregroundStyle(Color(.textSecondary))
                .fixedSize()
                .frame(minWidth: 44, alignment: .leading)
            Text(piece.title)
                .font(.subheadline)
                .fontWeight(.heavy)
                .strikethrough(piece.isDone)
                .foregroundStyle(piece.isDone ? Color(.textSecondary) : Color(.textPrimary))
                .lineLimit(1)
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
                .frame(width: 44, height: 40)
                .contentShape(.rect)
            }
            .buttonStyle(.plain)
            .accessibilityLabel(piece.isDone ? "Pezzo \(piece.title): fatto. Tocca per annullare" : "Segna il pezzo \(piece.title) come fatto")
        }
        .padding(.leading, 46)
        .frame(height: 40)
    }

    private var doneRow: some View {
        HStack(spacing: 8) {
            Text(activity.timeText)
                .font(.footnote)
                .fontWeight(.heavy)
                .frame(minWidth: 42, alignment: .leading)
            Text(activity.title)
                .font(.subheadline)
                .fontWeight(.heavy)
                .strikethrough()
                .layoutPriority(1)

            Text(activity.note)
                .font(.footnote)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)

            Button {
                activity.isDone.toggle()
            } label: {
                Image(systemName: "checkmark.circle.fill")
                    .font(.title2)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(Color(.onAccent), Color.accentColor)
                    .frame(width: 44, height: 44)
                    .contentShape(.rect)
            }
            .buttonStyle(.plain)
        }
        .lineLimit(1)
        .padding(.leading, 14)
        .padding(.trailing, 4)
        .frame(minHeight: 46)
        .foregroundStyle(Color(.textSecondary))
        .background(Color(.surfaceMuted))
        .clipShape(.rect(cornerRadius: 16))
        .fontDesign(.rounded)

    }
}

#Preview {
    @Previewable @State var gym = Activity.samples[3]
    ZStack {
        Color(.appBackground)
            .ignoresSafeArea()
        VStack(spacing: 8) {
            ActivityRow(activity: .constant(Activity.samples[0]))
            ActivityRow(activity: .constant(Activity.samples[2]))
            ActivityRow(activity: $gym)
        }
        .padding()
    }
}

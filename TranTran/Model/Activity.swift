//
//  Activity.swift
//  TranTran
//
//  Created by Andrea Migori on 04/10/2026.
//

import SwiftUI

enum ActivityColor: String, CaseIterable, Codable {
    case sun, mint, sky, rose, lilac, peach
    
    var fill: Color {
        switch self {
        case .sun: Color(.activitySun)
        case .mint: Color(.activityMint)
        case .sky: Color(.activitySky)
        case .rose: Color(.activityRose)
        case .lilac: Color(.activityLilac)
        case .peach: Color(.activityPeach)
        }
    }
}

struct Activity: Identifiable, Equatable {
    var id = UUID()
    var title: String
    var note: String
    var day = Calendar.current.startOfDay(for: .now)
    var hour: Int
    var minute: Int
    var durationMinutes: Int = 30
    var symbol: String
    var color: ActivityColor
    var isDone: Bool = false
    var pieces: [Piece] = []
    
    var timeText: String {
        String(format: "%02d:%02d", hour, minute)
    }
    
    var startMinutes: Int {
        hour * 60 + minute
    }
    
    var endMinutes: Int {
        startMinutes + durationMinutes
    }
    
    var endTimeText: String {
        String(format: "%02d:%02d", endMinutes / 60 % 24, endMinutes % 60)
    }
    
    var intervalText: String {
        "\(timeText) – \(endTimeText)"
    }
    
    func happens(on date: Date) -> Bool {
        Calendar.current.isDate(day, inSameDayAs: date)
    }
    
    func isNow(at minutes: Int) -> Bool {
        startMinutes <= minutes && minutes < endMinutes
    }
    
    func remainingText(at minutes: Int) -> String {
        let remaining = endMinutes - minutes
        let hours = remaining / 60
        let mins = remaining % 60
        if hours == 0 {
            return mins == 1 ? "Manca 1 min." : "Mancano \(mins) min."
        }
        if mins == 0 {
            return hours == 1 ? "Manca 1 h." : "Mancano \(hours) h."
        }
        return String(format: "Mancano %d h %02d.", hours, mins)
    }
    
    func progress(at minutes: Int) -> Double {
        Double(minutes - startMinutes) / Double(durationMinutes)
    }
    
    func pieceEnd(at index: Int) -> Int {
        if index + 1 < pieces.count {
            return pieces[index + 1].startMinutes
        }
        return endMinutes
    }
    
    func pieceShare(at index: Int) -> Double {
        let length = pieceEnd(at: index) - pieces[index].startMinutes
        let total = endMinutes - pieces[0].startMinutes
        if total <= 0 {
            return 0
        }
        return Double(length) / Double(total)
    }
    
    func pieceProgress(at index: Int, minutes: Int) -> Double {
        let start = pieces[index].startMinutes
        let length = pieceEnd(at: index) - start
        if length <= 0 {
            return 0
        }
        let value = Double(minutes - start) / Double(length)
        return min(max(value, 0), 1)
    }
    
    func nowPieceIndex(at minutes: Int) -> Int? {
        guard let timeIndex = pieces.indices.first(where: { index in
            pieces[index].startMinutes <= minutes && minutes < pieceEnd(at: index)
        }) else {
            return nil
        }
        return pieces.indices.first { index in
            index >= timeIndex && !pieces[index].isDone
        }
    }
    
    func nextPieceIndex(at minutes: Int) -> Int? {
        if let nowIndex = nowPieceIndex(at: minutes) {
            return pieces.indices.first { index in
                index > nowIndex && !pieces[index].isDone
            }
        }
        return pieces.indices.first { index in
            pieces[index].startMinutes > minutes && !pieces[index].isDone
        }
    }
    
    static let samples: [Activity] = [
        Activity(title: "Sveglia", note: "Alla quarta, ma conta.", hour: 7, minute: 0, durationMinutes: 30, symbol: "sun.max", color: .sky, isDone: true),
        Activity(title: "Lavoro profondo", note: "Profondo quanto basta.", hour: 9, minute: 0, durationMinutes: 240, symbol: "laptopcomputer", color: .sun, pieces: [
            Piece(title: "Mail", hour: 9, minute: 0),
            Piece(title: "Report", hour: 9, minute: 30),
            Piece(title: "Call con Marco", hour: 11, minute: 0) ]),
        Activity(title: "Pranzo", note: "Lontano dalla scrivania, grazie.", hour: 13, minute: 0, durationMinutes: 60, symbol: "fork.knife", color: .mint),
        Activity(title: "Palestra", note: "Rimandata tre volte. Zero pressioni.", hour: 18, minute: 30, durationMinutes: 90, symbol: "dumbbell", color: .rose, pieces: [
            Piece(title: "Riscaldamento", hour: 18, minute: 30),
            Piece(title: "Pesi", hour: 18, minute: 40),
            Piece(title: "Stretching, forse", hour: 19, minute: 45)
        ]),
        Activity(title: "Dormire", note: "Sul serio, stavolta.", hour: 23, minute: 0, durationMinutes: 480, symbol: "moon", color: .peach)
    ]
}

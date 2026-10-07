//
//  Activity.swift
//  TranTran
//
//  Created by Andrea Migori on 04/10/2026.
//

import SwiftUI

enum ActivityColor {
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

struct Activity: Identifiable {
    let id = UUID()
    var title: String
    var note: String
    var hour: Int
    var minute: Int
    var durationMinutes: Int = 30
    var symbol: String
    var color: ActivityColor
    var isDone: Bool = false
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
    static let samples: [Activity] = [
        Activity(title: "Sveglia", note: "Alla quarta, ma conta.", hour: 7, minute: 0, durationMinutes: 30, symbol: "sun.max", color: .sky, isDone: true),
        Activity(title: "Lavoro profondo", note: "Profondo quanto basta.", hour: 9, minute: 0, durationMinutes: 240, symbol: "laptopcomputer", color: .sun),
        Activity(title: "Pranzo", note: "Lontano dalla scrivania, grazie.", hour: 13, minute: 0, durationMinutes: 60, symbol: "fork.knife", color: .mint),
        Activity(title: "Palestra", note: "Rimandata tre volte. Zero pressioni.", hour: 18, minute: 30, durationMinutes: 90, symbol: "dumbbell", color: .rose),
        Activity(title: "Dormire", note: "Sul serio, stavolta.", hour: 23, minute: 0, durationMinutes: 480, symbol: "moon", color: .peach)
    ]
}

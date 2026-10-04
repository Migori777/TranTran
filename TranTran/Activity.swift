//
//  Activity.swift
//  TranTran
//
//  Created by Andrea Migori on 04/10/2026.
//

import Foundation

struct Activity: Identifiable {
    let id = UUID()
    var title: String
    var note: String
    var hour: Int
    var minute: Int
    var symbol: String
    var isDone: Bool = false
    static let samples: [Activity] = [
        Activity(title: "Sveglia", note: "Alla quarta, ma conta.", hour: 7, minute: 0, symbol: "sun.max", isDone: true),
        Activity(title: "Lavoro profondo", note: "Profondo quanto basta.", hour: 9, minute: 0, symbol: "laptopcomputer"),
        Activity(title: "Pranzo", note: "Lontano dalla scrivania, grazie.", hour: 13, minute: 0, symbol: "fork.knife"),
        Activity(title: "Palestra", note: "Rimandata tre volte. Zero pressioni.", hour: 18, minute: 30, symbol: "dumbbell"),
        Activity(title: "Dormire", note: "Sul serio, stavolta.", hour: 23, minute: 0, symbol: "moon")
    ]
}

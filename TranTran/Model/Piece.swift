//
//  Piece.swift
//  TranTran
//
//  Created by Andrea Migori on 20/10/2026.
//

import Foundation

struct Piece: Identifiable, Equatable {
    var id = UUID()
    var title: String
    var hour: Int
    var minute: Int
    var isDone: Bool = false
    
    var startMinutes: Int {
        hour * 60 + minute
    }

    var timeText: String {
        String(format: "%02d:%02d", hour, minute)
    }
}

//
//  StoredActivity.swift
//  TranTran
//
//  Created by Andrea Migori on 18/10/2026.
//

import Foundation
import SwiftData

@Model
final class StoredActivity {
    var id: UUID
    var title: String
    var note: String
    var day: Date
    var hour: Int
    var minute: Int
    var durationMinutes: Int
    var symbol: String
    var color: ActivityColor
    var isDone: Bool
    
    init(from activity: Activity) {
        id = activity.id
        title = activity.title
        note = activity.note
        day = activity.day
        hour = activity.hour
        minute = activity.minute
        durationMinutes = activity.durationMinutes
        symbol = activity.symbol
        color = activity.color
        isDone = activity.isDone
    }
    
    var activity: Activity {
        Activity(id: id, title: title, note: note, day: day, hour: hour, minute: minute, durationMinutes: durationMinutes, symbol: symbol, color: color, isDone: isDone)
    }
}

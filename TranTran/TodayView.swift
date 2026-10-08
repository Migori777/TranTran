//
//  TodayView.swift
//  TranTran
//
//  Created by Andrea Migori on 04/10/2026.
//

import SwiftUI

struct TodayView: View {
    @Bindable var store: ActivityStore
    @State private var selectedDate = Date.now
    
    private var today: Date {
        Date.now
    }
    
    private var dateText: String {
        let italian = Locale(identifier: "it_IT")
        let format = Date.FormatStyle.dateTime.weekday(.wide).day().month(.wide).locale(italian)
        return today.formatted(format)
    }
    
    private var weekday: Int {
        Calendar.current.component(.weekday, from: today)
    }
    
    private var nowMinutes: Int {
        let hour = Calendar.current.component(.hour, from: today)
        let minute = Calendar.current.component(.minute, from: today)
        return hour * 60 + minute
    }
    
    private var titleText: String {
        switch weekday {
        case 1: "Domenica. Fai poco."
        case 2: "Coraggio, è lunedì."
        case 3: "È solo martedì."
        case 4: "Metà strada. Forse."
        case 5: "Quasi venerdì."
        case 6: "Venerdì. Resisti."
        case 7: "Sabato. Con calma."
        default: "Un altro giorno."
        }
    }
    
    private var summaryText: String {
        let word = store.doneCount == 1 ? "fatta" : "fatte"
        if store.doneCount == store.activities.count {
            return "Ottimo! Hai completato tutte le attività!"
        }
        return "\(store.doneCount) \(word) su \(store.activities.count). Il resto è ottimismo."
    }
    
    var body: some View {
        TimelineView(.everyMinute) { _ in
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(dateText)
                            .font(.footnote)
                            .fontWeight(.heavy)
                            .textCase(.uppercase)
                            .kerning(0.8)
                            .foregroundStyle(Color(.textSecondary))
                        Text(titleText)
                            .font(.title)
                            .fontWeight(.black)
                        Text(summaryText)
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundStyle(Color(.textSecondary))
                    }
                    
                    WeekStrip(today: today, selectedDate: $selectedDate)
                    
                    VStack(spacing: 8) {
                        ForEach($store.activities) { $activity in
                            if activity.isNow(at: nowMinutes) && !activity.isDone {
                                NowCard(activity: $activity, nowMinutes: nowMinutes)
                            } else {
                                ActivityRow(activity: $activity)
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 8)
            }
            .background(Color(.appBackground))
            .foregroundStyle(Color(.textPrimary))
            .fontDesign(.rounded)
        }
    }
}

#Preview {
    TodayView(store: ActivityStore())
}

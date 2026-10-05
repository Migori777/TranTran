//
//  TodayView.swift
//  TranTran
//
//  Created by Andrea Migori on 04/10/2026.
//

import SwiftUI

struct TodayView: View {
    @State private var store = ActivityStore()
    
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
    
    private var doneCount: Int {
        store.activities.filter{ activity in activity.isDone }.count
    }
    
    private var summaryText: String {
        let word = doneCount == 1 ? "fatta" : "fatte"
        if doneCount == store.activities.count {
            return "Ottimo! Hai completato tutte le attività!"
        }
        return "\(doneCount) \(word) su \(store.activities.count). Il resto è ottimismo."
    }
    
    var body: some View {
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
                
                VStack(spacing: 8) {
                    ForEach($store.activities) { $activity in
                        ActivityRow(activity: $activity)
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

#Preview {
    TodayView()
}

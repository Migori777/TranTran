//
//  TodayView.swift
//  TranTran
//
//  Created by Andrea Migori on 04/10/2026.
//

import SwiftUI

struct TodayView: View {
    @Bindable var store: ActivityStore
    @Binding var isAdding: Bool
    @State private var selectedDate = Date.now
    @State private var editingActivity: Activity?
    
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
                    #if os(macOS)
                    MacHeader(dateText: dateText, titleText: titleText, summaryText: summaryText, isAdding: $isAdding)
                    #else
                    VStack(alignment: .leading, spacing: 4) {
                        HStack(spacing: 12) {
                            Text(dateText)
                                .font(.footnote)
                                .fontWeight(.heavy)
                                .textCase(.uppercase)
                                .kerning(0.8)
                                .foregroundStyle(Color(.textSecondary))
                                .lineLimit(1)
                                .minimumScaleFactor(0.75)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            StreakPill(days: 4)
                        }
                        Text(titleText)
                            .font(.title)
                            .fontWeight(.black)
                        Text(summaryText)
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundStyle(Color(.textSecondary))
                    }
                    WeekStrip(today: today, selectedDate: $selectedDate)
                    #endif

                    VStack(spacing: 8) {
                        ForEach($store.activities) { $activity in
                            if activity.isNow(at: nowMinutes) && !activity.isDone {
                                #if os(macOS)
                                MacNowRow(activity: $activity, nowMinutes: nowMinutes)
                                    .onTapGesture {
                                        editingActivity = activity
                                    }
                                #else
                                NowCard(activity: $activity, nowMinutes: nowMinutes)
                                    .onTapGesture {
                                        editingActivity = activity
                                    }
                                #endif
                            } else {
                                #if os(macOS)
                                MacActivityRow(activity: $activity)
                                    .onTapGesture {
                                        editingActivity = activity
                                    }
                                #else
                                ActivityRow(activity: $activity)
                                    .onTapGesture {
                                        editingActivity = activity
                                    }
                                #endif
                            }
                        }
                    }
                }
                #if os(macOS)
                .padding(.top, 26)
                .padding(.leading, 20)
                .padding(.trailing, 28)
                .padding(.bottom, 28)
                #else
                .padding(.horizontal, 20)
                .padding(.top, 8)
                #endif
            }
            .background(Color(.appBackground))
            .foregroundStyle(Color(.textPrimary))
            .fontDesign(.rounded)
        }
        .sheet(item: $editingActivity) { chosen in
            ActivityForm(store: store, activity: chosen)
        }
    }
}

#Preview {
    TodayView(store: ActivityStore(), isAdding: .constant(false))
}

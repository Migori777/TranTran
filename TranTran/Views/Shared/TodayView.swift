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
    @State private var draft: Activity?
    
    private var today: Date {
        Date.now
    }
    
    private var dateText: String {
        let italian = Locale(identifier: "it_IT")
        let format = Date.FormatStyle.dateTime.weekday(.wide).day().month(.wide).locale(italian)
        return selectedDate.formatted(format)
    }
    
    private var weekday: Int {
        Calendar.current.component(.weekday, from: selectedDate)
    }
    
    private var nowMinutes: Int {
        let hour = Calendar.current.component(.hour, from: today)
        let minute = Calendar.current.component(.minute, from: today)
        return hour * 60 + minute
    }
    
    private var isShowingToday: Bool {
        Calendar.current.isDate(selectedDate, inSameDayAs: today)
    }
    
    private var titleText: String {
        if Calendar.current.isDateInYesterday(selectedDate) {
            return "Ieri. Ormai è andata."
        }
        
        if Calendar.current.isDateInTomorrow(selectedDate) {
            return "Domani. Si vedrà."
        }
        return switch weekday {
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
        let total = store.count(on: selectedDate)
        let done = store.doneCount(on: selectedDate)
        let word = done == 1 ? "fatta" : "fatte"
        if total == 0 {
            return "Niente in programma."
        }
        if isShowingToday {
            if done == total {
                return "Ottimo! Hai completato tutte le attività!"
            }
            return "\(done) \(word) su \(total). Il resto è ottimismo."
        }
        if selectedDate > today {
            return "\(total) in programma. Nessuna fretta."
        }
        return "\(done) \(word) su \(total). Il resto è storia."
    }
    
    private var nowIndex: Int? {
        store.activities.firstIndex { activity in
            activity.happens(on: today) && activity.isNow(at: nowMinutes) && !activity.isDone
        }
    }
    
    private var nextIndex: Int? {
        store.activities.firstIndex { activity in
            activity.happens(on: today) && activity.startMinutes > nowMinutes && !activity.isDone
        }
    }
    
    private var activityAfterDraft: Activity? {
        if let draft {
            return store.activities.first { activity in
                activity.happens(on: selectedDate) && activity.startMinutes > draft.startMinutes
            }
        }
        return nil
    }
    
    private func toggleSelection(of activity: Activity) {
        isAdding = false
        if editingActivity?.id == activity.id {
            editingActivity = nil
        } else {
            editingActivity = activity
        }
    }
    
    
    private var listColumn: some View {
        VStack(alignment: .leading, spacing: 16) {
            #if os(macOS)
            MacHeader(dateText: dateText, titleText: titleText, summaryText: summaryText, selectedDate: $selectedDate, isAdding: $isAdding)
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
                    if activity.happens(on: selectedDate) {
                        #if os(macOS)
                        if let draft, activity.id == activityAfterDraft?.id {
                            MacActivityRow(activity: .constant(draft), isSelected: true)
                        }
                        #endif
                        if isShowingToday && activity.isNow(at: nowMinutes) && !activity.isDone {
                            #if os(macOS)
                            MacNowRow(activity: $activity, nowMinutes: nowMinutes, isSelected: editingActivity?.id == activity.id)
                                .onTapGesture {
                                    toggleSelection(of: activity)
                                }
                            #else
                            NowCard(activity: $activity, nowMinutes: nowMinutes)
                                .onTapGesture {
                                    editingActivity = activity
                                }
                            #endif
                        } else {
                            #if os(macOS)
                            MacActivityRow(activity: $activity, isSelected: editingActivity?.id == activity.id)
                                .onTapGesture {
                                    toggleSelection(of: activity)
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
                #if os(macOS)
                if let draft, activityAfterDraft == nil {
                    MacActivityRow(activity: .constant(draft), isSelected: true)
                }
                #endif
            }
        }
    }
    
    private var sideColumn: some View {
        VStack(spacing: 16) {
            if isAdding {
                ActivityForm(store: store, isPanel: true, onClose: { isAdding = false }, onDraftChange: { newDraft in draft = newDraft })
            } else if let chosen = editingActivity {
                ActivityForm(store: store, activity: chosen, isPanel: true, onClose: { editingActivity = nil })
                    .id(chosen.id)
            } else if let index = nowIndex {
                NowSummaryCard(activity: $store.activities[index], label: "In corso")
            } else if let index = nextIndex{
                NowSummaryCard(activity: $store.activities[index], label: "Prossima")
            } else {
                DayDoneCard()
            }
        }
    }
    
    var body: some View {
        TimelineView(.everyMinute) { _ in
            #if os(macOS)
            HStack(spacing: 0) {
                ScrollView {
                    listColumn
                        .padding(.top, 26)
                        .padding(.leading, 20)
                        .padding(.trailing, 24)
                        .padding(.bottom, 28)
                }
                ScrollView {
                    sideColumn
                        .padding(.top, 26)
                        .padding(.trailing, 28)
                        .padding(.bottom, 28)
                }
                .frame(width: 308)
            }
            #else
            ScrollView {
                listColumn
                    .padding(.horizontal, 20)
                    .padding(.top, 8)
            }
            #endif
        }
        .background(Color(.appBackground))
        .foregroundStyle(Color(.textPrimary))
        .fontDesign(.rounded)
        .onChange(of: selectedDate) {
            editingActivity = nil
        }
        .onChange(of: isAdding) {
            if isAdding {
                editingActivity = nil
            } else {
                draft = nil
            }
        }
        #if os(iOS)
        .sheet(item: $editingActivity) { chosen in
            ActivityForm(store: store, activity: chosen)
        }
        #endif
    }
}

#Preview {
    TodayView(store: ActivityStore(), isAdding: .constant(false))
}

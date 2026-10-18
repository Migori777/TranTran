//
//  ActivityStore.swift
//  TranTran
//
//  Created by Andrea Migori on 05/10/2026.
//

import SwiftUI
import SwiftData

@Observable
class ActivityStore {
    var activities = Activity.samples {
        didSet {
            save()
        }
    }
    private let container: ModelContainer?
    
    init(isSaved: Bool = false) {
        if isSaved {
            container = try? ModelContainer(for: StoredActivity.self)
        } else {
            container = nil
        }
        load()
    }
    
    func count(on date: Date) -> Int {
        activities.filter { activity in activity.happens(on: date) }.count
    }
    
    func doneCount(on date: Date) -> Int {
        activities.filter { activity in activity.happens(on: date) && activity.isDone }.count
    }
    
    func add(_ activity: Activity) {
        activities.append(activity)
        activities.sort {first, second in first.startMinutes < second.startMinutes}
    }
    
    func update(_ activity: Activity) {
        activities.removeAll { item in item.id == activity.id }
        add(activity)
    }
    
    func delete(_ activity: Activity) {
        activities.removeAll { item in item.id == activity.id }
    }
    
    private func load() {
        guard let context = container?.mainContext else { return }
        let saved = (try? context.fetch(FetchDescriptor<StoredActivity>())) ?? []
        if saved.isEmpty {
            save()
        } else {
            let loaded = saved.map { item in item.activity }
            activities = loaded.sorted { first, second in first.startMinutes < second.startMinutes }
        }
    }
    
    private func save() {
        guard let context = container?.mainContext else { return }
        try? context.delete(model: StoredActivity.self)
        for activity in activities {
            context.insert(StoredActivity(from: activity))
        }
        try? context.save()
    }
}

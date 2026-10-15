//
//  ActivityStore.swift
//  TranTran
//
//  Created by Andrea Migori on 05/10/2026.
//

import SwiftUI

@Observable
class ActivityStore {
    var activities = Activity.samples
    var doneCount: Int {
        activities.filter{ activity in activity.isDone }.count
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
}

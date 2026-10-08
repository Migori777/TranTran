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
}

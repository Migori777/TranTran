//
//  ContentView.swift
//  TranTran
//
//  Created by Andrea Migori on 04/10/2026.
//

import SwiftUI

enum AppSection {
    case today
    case routine
    case balance
}

struct ContentView: View {
    @State private var store = ActivityStore()
    @State private var selectedSection = AppSection.today
    var body: some View {
        TabView(selection: $selectedSection) {
            Tab("Oggi", systemImage: "calendar", value: .today) {
                TodayView(store: store)
            }
            Tab("Routine", systemImage: "repeat", value: .routine) {
                Text("Routine")
            }
            Tab("Bilancio", systemImage: "chart.bar", value: .balance) {
                Text("\(store.doneCount)")
            }
        }
        .tabViewStyle(.sidebarAdaptable)
    }
}

#Preview {
    ContentView()
}

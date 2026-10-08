//
//  ContentView.swift
//  TranTran
//
//  Created by Andrea Migori on 04/10/2026.
//

import SwiftUI

struct ContentView: View {
    @State private var store = ActivityStore()
    var body: some View {
        TabView {
            Tab("Oggi", systemImage: "calendar") {
                TodayView(store: store)
            }
            Tab("Routine", systemImage: "repeat") {
                Text("Routine")
            }
            Tab("Bilancio", systemImage: "chart.bar") {
                Text("\(store.doneCount)")
            }
        }
        .tabViewStyle(.sidebarAdaptable)
    }
}

#Preview {
    ContentView()
}

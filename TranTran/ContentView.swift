//
//  ContentView.swift
//  TranTran
//
//  Created by Andrea Migori on 04/10/2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Oggi", systemImage: "calendar") {
                TodayView()
            }
            Tab("Routine", systemImage: "repeat") {
                Text("Routine")
            }
            Tab("Bilancio", systemImage: "chart.bar") {
                Text("Bilancio")
            }
        }
        .tabViewStyle(.sidebarAdaptable)
    }
}

#Preview {
    ContentView()
}

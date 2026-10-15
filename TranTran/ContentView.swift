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
    @State private var isAddingActivity = false
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedSection) {
                Tab("Oggi", systemImage: "calendar", value: .today) {
                    TodayView(store: store)
                        .replacingSystemTabBar()
                }
                Tab("Routine", systemImage: "repeat", value: .routine) {
                    Text("Routine")
                        .replacingSystemTabBar()
                }
                Tab("Bilancio", systemImage: "chart.bar", value: .balance) {
                    Text("\(store.doneCount)")
                        .replacingSystemTabBar()
                }
            }
            .tabViewStyle(.sidebarAdaptable)
            #if os(iOS)
            HStack(spacing: 10) {
                TabBar(selection: $selectedSection)
                AddButton(isAdding: $isAddingActivity)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 26)
            .ignoresSafeArea(edges: .bottom)
            #endif
        }
        .sheet(isPresented: $isAddingActivity) {
            ActivityForm(store: store)
        }
    }
}

#Preview {
    ContentView()
}

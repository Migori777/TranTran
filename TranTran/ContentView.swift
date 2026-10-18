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

extension FocusedValues {
    @Entry var isAddingActivity: Binding<Bool>?
}

struct ContentView: View {
    @State private var store = ActivityStore(isSaved: true)
    @State private var selectedSection = AppSection.today
    @State private var isAddingActivity = false
    @State private var selectedDate = Date.now
    
    var body: some View {
        #if os(macOS)
        HStack(spacing: 0) {
            MacSidebar(selection: $selectedSection)
            switch selectedSection {
            case .today:
                TodayView(store: store, selectedDate: $selectedDate, isAdding: $isAddingActivity)
            case .routine:
                Text("Routine")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            case .balance:
                Text("Bilancio")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .frame(minWidth: 1220, minHeight: 600)
        .background(Color(.appBackground))
        .ignoresSafeArea()
        .toolbar {
            ToolbarSpacer(.flexible)
        }
        .toolbar(removing: .title)
        .toolbarBackgroundVisibility(.hidden, for: .windowToolbar)
        .windowToolbarFullScreenVisibility(.onHover)
        .focusedSceneValue(\.isAddingActivity, $isAddingActivity)
        .onChange(of: isAddingActivity) {
            if isAddingActivity {
                selectedSection = .today
            }
        }
        #else
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedSection) {
                Tab("Oggi", systemImage: "calendar", value: .today) {
                    TodayView(store: store, selectedDate: $selectedDate, isAdding: $isAddingActivity)
                        .replacingSystemTabBar()
                }
                Tab("Routine", systemImage: "repeat", value: .routine) {
                    Text("Routine")
                        .replacingSystemTabBar()
                }
                Tab("Bilancio", systemImage: "chart.bar", value: .balance) {
                    Text("\(store.doneCount(on: .now))")
                        .replacingSystemTabBar()
                }
            }
            .tabViewStyle(.sidebarAdaptable)
            HStack(spacing: 10) {
                TabBar(selection: $selectedSection)
                AddButton(isAdding: $isAddingActivity)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 26)
            .ignoresSafeArea(edges: .bottom)
        }
        .sheet(isPresented: $isAddingActivity) {
            ActivityForm(store: store, selectedDay: selectedDate)
        }
        #endif
    }
}

#Preview {
    ContentView()
}

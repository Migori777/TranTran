//
//  TranTranApp.swift
//  TranTran
//
//  Created by Andrea Migori on 04/10/2026.
//

import SwiftUI

@main
struct TranTranApp: App {
    @State private var isShowingSplash = true

    var body: some Scene {
        WindowGroup {
            ContentView()
                .overlay {
                    if isShowingSplash {
                        SplashView(isShowing: $isShowingSplash)
                            .transition(.opacity)
                    }
                }
                .animation(.easeOut(duration: 0.35), value: isShowingSplash)
        }
        #if os(macOS)
        .defaultSize(width: 1280, height:800)
        #endif
    }
}

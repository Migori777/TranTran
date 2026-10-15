//
//  SplashView.swift
//  TranTran
//
//  Created by Claude on 15/10/2026.
//

import SwiftUI

struct SplashView: View {
    @Binding var isShowing: Bool
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var iconScale = 1.0
    @State private var isTextVisible = false

    var body: some View {
        ZStack {
            Color(.appBackground)
            Image(.launchIcon)
                .scaleEffect(iconScale)
            VStack(spacing: 2) {
                Text("TranTran")
                    .font(.system(size: 28))
                    .fontWeight(.black)
                    .foregroundStyle(Color(.textPrimary))
                Text("Il solito tran tran.")
                    .font(.system(size: 15))
                    .fontWeight(.bold)
                    .foregroundStyle(Color(.textSecondary))
            }
            .offset(y: isTextVisible ? 110 : 124)
            .opacity(isTextVisible ? 1 : 0)
        }
        .fontDesign(.rounded)
        .ignoresSafeArea()
        .task {
            await play()
        }
    }

    private func play() async {
        if !reduceMotion {
            withAnimation(.easeIn(duration: 0.12)) {
                iconScale = 0.88
            }
            try? await Task.sleep(for: .seconds(0.12))
        }
        withAnimation(.spring(duration: 0.5, bounce: 0.6)) {
            iconScale = 1
            isTextVisible = true
        }
        try? await Task.sleep(for: .seconds(1.1))
        withAnimation(.easeOut(duration: 0.35)) {
            isShowing = false
        }
    }
}

#Preview {
    SplashView(isShowing: .constant(true))
}

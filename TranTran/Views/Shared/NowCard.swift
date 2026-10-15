//
//  NowCard.swift
//  TranTran
//
//  Created by Andrea Migori on 07/10/2026.
//

import SwiftUI

struct NowCard: View {
    @Binding var activity: Activity
    let nowMinutes: Int
    
    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Adesso · \(activity.intervalText)")
                    .font(.caption)
                    .fontWeight(.black)
                    .textCase(.uppercase)
                    .kerning(1)
                Text(activity.title)
                    .font(.title2)
                    .fontWeight(.black)
                Text("\(activity.note) \(activity.remainingText(at: nowMinutes))")
                    .font(.footnote)
                    .fontWeight(.bold)
                    .opacity(0.8)
                progressBar
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Button {
                activity.isDone.toggle()
            } label: {
                Image(systemName: "checkmark")
                    .font(.body)
                    .fontWeight(.heavy)
                    .foregroundStyle(.white)
                    .frame(width: 56, height: 56)
                    .background(Color(.activityInk))
                    .clipShape(.circle)
            }
            .buttonStyle(.plain)
        }
        .padding(.vertical, 16)
        .padding(.leading, 18)
        .padding(.trailing, 14)
        .frame(minHeight: 120)
        .foregroundStyle(Color(.activityInk))
        .background(activity.color.fill)
        .clipShape(.rect(cornerRadius: 26))
        .fontDesign(.rounded)
    }
    
    private var progressBar: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color(.activityInk).opacity(0.16))
                Capsule()
                    .fill(Color(.activityInk))
                    .frame(width: geometry.size.width * activity.progress(at: nowMinutes))
            }
        }
        .frame(height: 8)
        .padding(.top, 4)
    }
}

#Preview {
    ZStack {
        Color(.appBackground)
            .ignoresSafeArea()
        NowCard(activity: .constant(Activity.samples[1]), nowMinutes: 11 * 60 + 20)
            .padding()
    }
}

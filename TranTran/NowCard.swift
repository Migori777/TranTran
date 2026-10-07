//
//  NowCard.swift
//  TranTran
//
//  Created by Andrea Migori on 07/10/2026.
//

import SwiftUI

struct NowCard: View {
    @Binding var activity: Activity
    
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
                Text(activity.note)
                    .font(.footnote)
                    .fontWeight(.bold)
                    .opacity(0.8)
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
}

#Preview {
    ZStack {
        Color(.appBackground)
            .ignoresSafeArea()
        NowCard(activity: .constant(Activity.samples[1]))
            .padding()
    }
}

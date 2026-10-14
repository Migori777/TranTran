//
//  ActivityForm.swift
//  TranTran
//
//  Created by Andrea Migori on 14/10/2026.
//

import SwiftUI

struct ActivityForm: View {
    @Environment(\.dismiss) private var dismiss
    @State private var title = ""
    @State private var note = ""
    @State private var startTime = Calendar.current.nextDate(after: .now, matching: DateComponents(minute: 0), matchingPolicy: .nextTime) ?? .now
    @State private var isPickingTime = false
    @State private var durationMinutes = 30
    
    private var startText: String {
        startTime.formatted(.dateTime.hour().minute().locale(Locale(identifier: "it_IT")))
    }
    
    private var endText: String {
        let endTime = Calendar.current.date(byAdding: .minute, value: durationMinutes, to: startTime) ?? startTime
        return endTime.formatted(.dateTime.hour().minute().locale(Locale(identifier: "it_IT")))
    }
    
    private func durationText(_ minutes: Int) -> String {
        if minutes < 60 {
            return "\(minutes) min"
        } else if minutes % 60 == 0 {
            return "\(minutes / 60) h"
        }
        return "\(minutes / 60) h \(minutes % 60)"
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20){
                    HStack(spacing: 14) {
                        Image(systemName: "alarm")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color(.activityInk))
                            .frame(width: 56, height: 56)
                            .background(Color(.activitySun))
                            .clipShape(.rect(cornerRadius: 19))
                        VStack(alignment: .leading, spacing: 4) {
                            TextField("Titolo", text: $title, prompt: Text("Cosa c'è da fare?").foregroundStyle(Color(.textSecondary)))
                                .font(.title3)
                                .fontWeight(.black)
                            TextField("Battuta", text: $note, prompt: Text("Una battuta, per convincerti").foregroundStyle(Color(.textSecondary)))
                                .font(.footnote)
                                .fontWeight(.bold)
                                .foregroundStyle(Color(.textSecondary))
                        }
                    }
                    .padding(.vertical, 14)
                    .padding(.leading, 14)
                    .padding(.trailing, 16)
                    .background(Color(.surface))
                    .clipShape(.rect(cornerRadius: 24))
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Quando")
                            .font(.caption)
                            .fontWeight(.heavy)
                            .textCase(.uppercase)
                            .kerning(0.7)
                            .foregroundStyle(Color(.textSecondary))
                            .padding(.leading, 4)
                        VStack(alignment: .leading, spacing: 0) {
                            HStack {
                                Text("Inizio")
                                    .font(.callout)
                                    .fontWeight(.heavy)
                                Spacer()
                                Button {
                                    withAnimation(.snappy) {
                                        isPickingTime.toggle()
                                    }
                                } label: {
                                    Text(startText)
                                        .font(.body)
                                        .fontWeight(.black)
                                        .foregroundStyle(Color.accentColor)
                                        .padding(.horizontal, 14)
                                        .frame(height: 36)
                                        .background(Color(.accentSoft))
                                        .clipShape(.rect(cornerRadius: 12))
                                }
                                .buttonStyle(.plain)
                            }
                            .frame(height: 56)
                            if isPickingTime {
                                DatePicker("Inizio", selection: $startTime, displayedComponents: .hourAndMinute)
                                    .labelsHidden()
                                #if os(iOS)
                                    .datePickerStyle(.wheel)
                                #endif
                                    .environment(\.locale, Locale(identifier: "it_IT"))
                                    .frame(maxWidth: .infinity)
                            }
                            Rectangle()
                                .fill(Color(.textPrimary).opacity(0.08))
                                .frame(height: 1)
                            Text("Durata")
                                .font(.callout)
                                .fontWeight(.heavy)
                                .padding(.top, 14)
                            LazyVGrid(columns: [GridItem(.flexible(), spacing: 8), GridItem(.flexible(), spacing: 8), GridItem(.flexible(), spacing: 8)], spacing: 8) {
                                ForEach([15, 30, 60, 120, 240], id: \.self) { option in
                                    Button {
                                        durationMinutes = option
                                    } label: {
                                        ChoiceChip(title: durationText(option), isSelected: durationMinutes == option)
                                    }
                                    .buttonStyle(.plain)
                                }
                                Button{
                                } label: {
                                    ChoiceChip(title: "Altro...", isSelected: false)
                                }
                                .buttonStyle(.plain)
                            }
                            .padding(.top, 10)
                            Text("Finisce alle \(endText). In teoria.")
                                .font(.footnote)
                                .fontWeight(.bold)
                                .foregroundStyle(Color(.textSecondary))
                                .padding(.top, 12)
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 16)
                        .background(Color(.surface))
                        .clipShape(.rect(cornerRadius: 20))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(Color(.textPrimary))
                .padding(.horizontal, 20)
                .padding(.top, 16)
            }
            .background(Color(.appBackground))
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(role: .close){
                        dismiss()
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("Nuova attività")
                        .font(.headline)
                        .fontWeight(.heavy)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(role: .confirm) {
                        dismiss()
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
        .presentationDragIndicator(.visible)
        .fontDesign(.rounded)
    }
}

struct ChoiceChip: View {
    let title: String
    let isSelected: Bool
    
    var body: some View {
        Text(title)
            .font(.subheadline)
            .fontWeight(isSelected ? .black : .heavy)
            .foregroundStyle(isSelected ? Color(.onAccent) : Color(.textPrimary))
            .frame(maxWidth: .infinity, minHeight: 40)
            .background(isSelected ? Color.accentColor : Color(.textPrimary).opacity(0.08))
            .clipShape(.capsule)
    }
}

#Preview {
    ActivityForm()
}

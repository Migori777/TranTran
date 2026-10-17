//
//  ActivityForm.swift
//  TranTran
//
//  Created by Andrea Migori on 14/10/2026.
//

import SwiftUI

struct ActivityForm: View {
    let store: ActivityStore
    var activity: Activity? = nil
    var isPanel = false
    var onClose: () -> Void = {}
    @Environment(\.dismiss) private var dismiss
    @State private var title = ""
    @State private var note = ""
    @State private var startTime = Calendar.current.nextDate(after: .now, matching: DateComponents(minute: 0), matchingPolicy: .nextTime) ?? .now
    @State private var isPickingTime = false
    @State private var durationMinutes = 30
    @State private var isPickingDuration = false
    @State private var color = ActivityColor.sun
    @State private var symbol = "alarm"
    
    private let durationPresets = [15, 30, 60, 120, 240]
    private let panelDurations = [15, 30, 45, 60, 90, 120, 180, 240, 300, 360, 480, 600, 720]
    private let symbolChoices = ["alarm", "cup.and.saucer", "laptopcomputer", "video", "fork.knife", "dumbbell", "book.closed", "moon", "cart", "leaf", "heart", "music.note"]
    
    private var isCustomDuration: Bool {
        !durationPresets.contains(durationMinutes)
    }
    
    private var formTitle: String {
        activity == nil ? "Nuova attività" : "Modifica attività"
    }
    
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
    
    private func moveStart(by minutes: Int) {
        startTime = Calendar.current.date(byAdding: .minute, value: minutes, to: startTime) ?? startTime
    }
    
    private func save() {
        let hour = Calendar.current.component(.hour, from: startTime)
        let minute = Calendar.current.component(.minute, from: startTime)
        if let activity {
            var changed = activity
            changed.title = title
            changed.note = note
            changed.hour = hour
            changed.minute = minute
            changed.durationMinutes = durationMinutes
            changed.symbol = symbol
            changed.color = color
            store.update(changed)
        } else {
            let newActivity = Activity(title: title, note: note, hour: hour, minute: minute, durationMinutes: durationMinutes, symbol: symbol, color: color)
            store.add(newActivity)
        }
        dismiss()
    }
    
    var body: some View {
        Group {
            if isPanel {
                panelBody
            } else {
                sheetBody
            }
        }
        .fontDesign(.rounded)
        .onAppear {
            if let activity {
                title = activity.title
                note = activity.note
                startTime = Calendar.current.date(bySettingHour: activity.hour, minute: activity.minute, second: 0, of: .now) ?? startTime
                durationMinutes = activity.durationMinutes
                color = activity.color
                symbol = activity.symbol
            }
        }
    }
    
    private var panelBody: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Text(formTitle)
                    .font(.system(size: 12))
                    .fontWeight(.heavy)
                    .textCase(.uppercase)
                    .kerning(0.7)
                    .foregroundStyle(Color(.textSecondary))
                Spacer()
                Button {
                    onClose()
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 8))
                        .fontWeight(.heavy)
                        .frame(width: 26, height: 26)
                        .background(Color(.textPrimary).opacity(0.08))
                        .clipShape(.circle)
                }
                .buttonStyle(.plain)
                .keyboardShortcut(.cancelAction)
                .accessibilityLabel("Chiudi")
            }
            
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 12) {
                    Image(systemName: symbol)
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                        .foregroundStyle(Color(.activityInk))
                        .frame(width: 44, height: 44)
                        .background(color.fill)
                        .clipShape(.rect(cornerRadius: 15))
                    TextField("Titolo", text: $title, prompt: Text("Cosa c'è da fare?").foregroundStyle(Color(.textSecondary)))
                        .font(.system(size: 19))
                        .fontWeight(.black)
                }
                TextField("Battuta", text: $note, prompt: Text("Una battuta, per convincerti").foregroundStyle(Color(.textSecondary)))
                    .font(.system(size: 14))
                    .fontWeight(.bold)
                    .foregroundStyle(Color(.textSecondary))
            }
            .textFieldStyle(.plain)
            
            VStack(alignment: .leading, spacing: 0) {
                Rectangle()
                    .fill(Color(.textPrimary).opacity(0.08))
                    .frame(height: 1)
                HStack {
                    Text("Inizio")
                        .fontWeight(.bold)
                        .foregroundStyle(Color(.textSecondary))
                    Spacer()
                    HStack(spacing: 4) {
                        Text(startText)
                            .fontWeight(.black)
                            .foregroundStyle(Color.accentColor)
                            .padding(.horizontal, 12)
                            .frame(height: 28)
                            .background(Color(.accentSoft))
                            .clipShape(.rect(cornerRadius: 10))
                        VStack(spacing: 0) {
                            Button {
                                moveStart(by: 15)
                            } label: {
                                Image(systemName: "chevron.up")
                                    .font(.system(size: 7))
                                    .fontWeight(.heavy)
                                    .frame(width: 20, height: 14)
                                    .contentShape(.rect)
                            }
                            .buttonStyle(.plain)
                            .accessibilityLabel("Un quarto d'ora più tardi")
                            Button {
                                moveStart(by: -15)
                            } label: {
                                Image(systemName: "chevron.down")
                                    .font(.system(size: 7))
                                    .fontWeight(.heavy)
                                    .frame(width: 20, height: 14)
                                    .contentShape(.rect)
                            }
                            .buttonStyle(.plain)
                            .accessibilityLabel("Un quarto d'ora prima")
                        }
                        .background(Color(.textPrimary).opacity(0.08))
                        .clipShape(.rect(cornerRadius: 10))
                    }
                }
                .padding(.vertical, 8)
                Rectangle()
                    .fill(Color(.textPrimary).opacity(0.08))
                    .frame(height: 1)
                HStack {
                    Text("Durata")
                        .fontWeight(.bold)
                        .foregroundStyle(Color(.textSecondary))
                    Spacer()
                    Menu {
                        Picker("Durata", selection: $durationMinutes) {
                            ForEach(panelDurations, id: \.self) { value in
                                Text(durationText(value))
                                    .tag(value)
                            }
                        }
                        .pickerStyle(.inline)
                        .labelsHidden()
                    } label: {
                        HStack(spacing: 6) {
                            Text(durationText(durationMinutes))
                                .fontWeight(.heavy)
                            Image(systemName: "chevron.up.chevron.down")
                                .font(.system(size: 8))
                                .fontWeight(.heavy)
                        }
                        .padding(.leading, 12)
                        .padding(.trailing, 10)
                        .frame(height: 28)
                        .background(Color(.textPrimary).opacity(0.08))
                        .clipShape(.capsule)
                    }
                    .menuStyle(.button)
                    .buttonStyle(.plain)
                    .menuIndicator(.hidden)
                    .fixedSize()
                }
                .padding(.vertical, 8)
                Rectangle()
                    .fill(Color(.textPrimary).opacity(0.08))
                    .frame(height: 1)
                Text("Finisce alle \(endText). In teoria.")
                    .font(.system(size: 13))
                    .fontWeight(.bold)
                    .foregroundStyle(Color(.textSecondary))
                    .padding(.top, 8)
            }
            .font(.system(size: 14))
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.surface))
        .clipShape(.rect(cornerRadius: 24))
    }
    
    
    private var sheetBody: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20){
                    HStack(spacing: 14) {
                        Image(systemName: symbol)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color(.activityInk))
                            .frame(width: 56, height: 56)
                            .background(color.fill)
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
                        .textFieldStyle(.plain)
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
                                ForEach(durationPresets, id: \.self) { option in
                                    Button {
                                        withAnimation(.snappy) {
                                            durationMinutes = option
                                            isPickingDuration = false
                                        }
                                    } label: {
                                        ChoiceChip(title: durationText(option), isSelected: durationMinutes == option)
                                    }
                                    .buttonStyle(.plain)
                                }
                                Button{
                                    withAnimation(.snappy) {
                                        isPickingDuration.toggle()
                                    }
                                } label: {
                                    ChoiceChip(title: isCustomDuration ? durationText(durationMinutes) : "Altro...", isSelected: isCustomDuration)
                                }
                                .buttonStyle(.plain)
                            }
                            .padding(.top, 10)
                            if isPickingDuration {
                                Picker("Durata", selection: $durationMinutes) {
                                    ForEach(Array(stride(from: 15, through: 720, by: 15)), id: \.self) { value in
                                        Text(durationText(value))
                                            .tag(value)
                                    }
                                }
                                .labelsHidden()
                                #if os(iOS)
                                .pickerStyle(.wheel)
                                #endif
                                .frame(maxWidth: .infinity)
                            }
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
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Colore")
                            .font(.caption)
                            .fontWeight(.heavy)
                            .textCase(.uppercase)
                            .kerning(0.7)
                            .foregroundStyle(Color(.textSecondary))
                            .padding(.leading, 4)
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 6), spacing: 8) {
                            ForEach(ActivityColor.allCases, id: \.self) { option in
                                Button {
                                    color = option
                                } label: {
                                    Circle()
                                        .fill(option.fill)
                                        .frame(width: 44, height: 44)
                                        .overlay {
                                            if color == option {
                                                Image(systemName: "checkmark")
                                                    .font(.caption)
                                                    .fontWeight(.heavy)
                                                    .foregroundStyle(Color(.activityInk))
                                                Circle()
                                                    .strokeBorder(Color.accentColor, lineWidth: 2.5)
                                                    .frame(width: 44, height: 44)
                                            }
                                        }
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.vertical, 14)
                        .padding(.horizontal, 16)
                        .background(Color(.surface))
                        .clipShape(.rect(cornerRadius: 20))
                    }
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Icona")
                            .font(.caption)
                            .fontWeight(.heavy)
                            .textCase(.uppercase)
                            .kerning(0.7)
                            .foregroundStyle(Color(.textSecondary))
                            .padding(.leading, 4)
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 6), spacing: 8) {
                            ForEach(symbolChoices, id: \.self) { option in
                                Button {
                                    symbol = option
                                } label : {
                                    Image(systemName: option)
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(symbol == option ? Color(.activityInk) : Color(.textPrimary))
                                        .frame(maxWidth: .infinity, minHeight: 46)
                                        .background(symbol == option ? color.fill : Color(.textPrimary).opacity(0.08))
                                        .clipShape(.rect(cornerRadius: 15))
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(14)
                        .background(Color(.surface))
                        .clipShape(.rect(cornerRadius: 20))
                    }
                    if let activity {
                        VStack(spacing: 8) {
                            Button(role: .destructive) {
                                store.delete(activity)
                                dismiss()
                            } label: {
                                Text("Elimina attività")
                                    .font(.callout)
                                    .fontWeight(.heavy)
                                    .foregroundStyle(Color(.danger))
                                    .frame(maxWidth: .infinity, minHeight: 52)
                                    .background(Color(.surface))
                                    .clipShape(.rect(cornerRadius: 20))
                            }
                            .buttonStyle(.plain)
                            Text("Nessuno lo saprà.")
                                .font(.footnote)
                                .fontWeight(.bold)
                                .foregroundStyle(Color(.textSecondary))
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(Color(.textPrimary))
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 40)
            }
            .background(Color(.appBackground))
            #if os(macOS)
            .navigationTitle(formTitle)
            #endif
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Annulla", systemImage: "xmark", role: .close){
                        dismiss()
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text(formTitle)
                        .font(.headline)
                        .fontWeight(.heavy)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(activity == nil ? "Aggiungi" : "Salva", systemImage: "checkmark", role: .confirm) {
                        save()
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
        .presentationDragIndicator(.visible)
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

#Preview("Nuova") {
    ActivityForm(store: ActivityStore())
}

#Preview("Modifica") {
    ActivityForm(store: ActivityStore(), activity: Activity.samples[1])
}

#Preview("Pannello") {
    ActivityForm(store: ActivityStore(), activity: Activity.samples[2], isPanel: true)
        .padding(20)
        .frame(width: 320)
        .background(Color(.appBackground))
        .foregroundStyle(Color(.textPrimary))
}

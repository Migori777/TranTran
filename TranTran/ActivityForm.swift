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
    
    private var startText: String {
        startTime.formatted(.dateTime.hour().minute().locale(Locale(identifier: "it_IT")))
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
                                Text(startText)
                                    .font(.body)
                                    .fontWeight(.black)
                                    .foregroundStyle(Color.accentColor)
                                    .padding(.horizontal, 14)
                                    .frame(height: 36)
                                    .background(Color(.accentSoft))
                                    .clipShape(.rect(cornerRadius: 12))
                            }
                            .frame(height: 56)
                        }
                        .padding(.horizontal, 16)
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

#Preview {
    ActivityForm()
}

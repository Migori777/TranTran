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

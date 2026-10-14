//
//  ActivityForm.swift
//  TranTran
//
//  Created by Andrea Migori on 14/10/2026.
//

import SwiftUI

struct ActivityForm: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20){
                }
                .frame(maxWidth: .infinity, alignment: .leading)
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

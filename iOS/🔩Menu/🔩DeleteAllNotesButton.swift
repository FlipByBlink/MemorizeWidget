import SwiftUI

struct 🔩DeleteAllNotesButton: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        Section {
            Menu {
                Button(role: .destructive) {
                    self.model.removeAllNotes()
                } label: {
                    Label("OK, delete all notes.", systemImage: "trash")
                }
            } label: {
                ZStack(alignment: .leading) {
                    Color.clear
                    Label("Delete all notes.", systemImage: "delete.backward.fill")
                        .foregroundColor(self.model.notes.isEmpty ? nil : .red)
                }
            }
            .disabled(self.model.notes.isEmpty)
        }
    }
}

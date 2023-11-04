import SwiftUI

struct 🚮DeleteNoteButton: View {
    @EnvironmentObject var model: 📱AppModel
    private var note: 📗Note
    var body: some View {
        Button(role: .destructive) {
            self.model.removeNote(self.note)
        } label: {
            Label("Delete", systemImage: "trash")
        }
    }
    init(_ note: 📗Note) {
        self.note = note
    }
}

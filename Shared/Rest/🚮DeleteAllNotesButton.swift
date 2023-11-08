import SwiftUI

struct 🚮DeleteAllNotesButton: View {
    @EnvironmentObject var model: 📱AppModel
    @State private var showDialog: Bool = false
    var body: some View {
        Button(role: .destructive) {
            self.showDialog = true
        } label: {
            Label("Delete all notes", systemImage: "delete.backward.fill")
        }
        .listItemTint(self.model.notes.isEmpty ? .accentColor : .red)
        .disabled(self.model.notes.isEmpty)
        .confirmationDialog("Delete all notes",
                            isPresented: self.$showDialog) {
            Button("OK, delete all notes.", role: .destructive) {
                withAnimation {
                    self.model.removeAllNotes()
                }
            }
        }
    }
}

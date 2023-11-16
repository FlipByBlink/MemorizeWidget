import SwiftUI

struct 🚮DeleteAllNotesButton: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        Button {
            self.model.presentedAllNotesDeleteConfirmDialog = true
        } label: {
            Label("Delete all notes", systemImage: "delete.backward.fill")
        }
        .listItemTint(self.model.notes.isEmpty ? nil : .red)
        .disabled(self.model.notes.isEmpty)
    }
}

extension 🚮DeleteAllNotesButton {
    struct ConfirmDialog: ViewModifier {
        @EnvironmentObject var model: 📱AppModel
        func body(content: Content) -> some View {
            content
                .confirmationDialog("Delete all notes",
                                    isPresented: self.$model.presentedAllNotesDeleteConfirmDialog) {
                    Button("OK, delete all notes.", role: .destructive) {
                        withAnimation {
                            self.model.removeAllNotes()
                        }
                    }
                }
        }
    }
}

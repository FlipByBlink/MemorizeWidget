import SwiftUI

struct 🚮DeleteAllNotesButton: View {
#if os(iOS) || os(watchOS)
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
#elseif os(macOS)
    @FocusedObject var model: 📱AppModel?
    var body: some View {
        Button("Delete all notes") {
            self.model?.presentedAllNotesDeleteConfirmDialog = true
        }
        .disabled(self.model?.notes.isEmpty == true)
    }
#endif
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

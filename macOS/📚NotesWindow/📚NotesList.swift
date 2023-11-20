import SwiftUI

struct 📚NotesList: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        List(selection: self.$model.notesSelection) {
            Section {
                ForEach(self.$model.notes) {
                    📗NoteRow(source: $0)
                }
                .onMove { self.model.moveNote($0, $1) }
                .onDelete { self.model.deleteNoteOnNotesList($0) }
            } footer: {
                Self.Footer()
            }
        }
        .toolbar { self.newNoteOnTopButton() }
        .onDeleteCommand { self.model.removeSelectedNote() }
        .onExitCommand { self.model.clearSelection() }
        .animation(.default, value: self.model.notes)
    }
}

private extension 📚NotesList {
    private func newNoteOnTopButton() -> some View {
        Button {
            self.model.addNewNoteOnTop()
        } label: {
            Label("新規ノート", systemImage: "plus")
        }
    }
    private struct Footer: View {
        @EnvironmentObject var model: 📱AppModel
        var body: some View {
            if self.model.notes.count > 10 {
                Text("ノート数: \(self.model.notes.count)")
            }
        }
    }
}

import SwiftUI

struct 📚NotesListPanel: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        List(selection: self.$model.notesSelection) {
            Section {
                ForEach(self.$model.notes) {
                    📗NoteView(source: $0)
                }
                .onMove { self.model.moveNote($0, $1) }
                .onDelete { self.model.deleteNoteOnNotesList($0) }
            } footer: {
                if self.model.notes.count > 10 {
                    Text("ノート数: \(self.$model.notes.count)")
                }
            }
        }
        .toolbar { self.newNoteButton() }
        .navigationTitle("ノートリスト")
        .onDeleteCommand { self.model.removeSelectedNote() }
        .onExitCommand { self.model.clearSelection() }
        .animation(.default, value: self.model.notes)
    }
}

private extension 📚NotesListPanel {
    private func newNoteButton() -> some View {
        Button {
            self.model.addNewNoteOnTop()
        } label: {
            Label("新規ノート", systemImage: "plus")
        }
    }
}

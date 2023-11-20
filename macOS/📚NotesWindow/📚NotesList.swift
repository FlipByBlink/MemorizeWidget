import SwiftUI

struct 📚NotesList: View {
    @EnvironmentObject var model: 📱AppModel
    @FocusState private var focusedNoteID: UUID?
    var body: some View {
        List(selection: self.$model.notesSelection) {
            Section {
                ForEach(self.$model.notes) { ⓝote in
                    📗NoteRow(source: ⓝote)
                        .focused(self.$focusedNoteID, equals: ⓝote.id)
                        .onChange(of: self.model.createdNewNoteID) {
                            if $0 == ⓝote.id {
                                self.focusedNoteID = ⓝote.id
                                self.model.createdNewNoteID = nil
                            }
                        }
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
            self.model.addNewNoteOnTop() //TODO: 修正
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

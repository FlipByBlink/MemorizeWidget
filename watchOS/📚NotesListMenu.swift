import SwiftUI

struct 📚NotesListMenu: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        List {
            self.newNoteButton()
            ForEach(self.$model.notes) { ⓝote in
                NavigationLink {
                    📗NoteView(ⓝote, .notesMenu)
                } label: {
                    Self.NoteLinkLabel(note: ⓝote)
                }
            }
            .onMove {
                self.model.moveNoteForDynamicView($0, $1)
                💥Feedback.light()
            }
            .onDelete(perform: self.model.deleteNotesForDynamicView)
        }
        .animation(.default, value: self.model.notes)
        .navigationTitle("Notes")
    }
}

private extension 📚NotesListMenu {
    private func newNoteButton() -> some View {
        TextFieldLink {
            Label("New note", systemImage: "plus")
        } onSubmit: {
            self.model.insertOnTop([.init($0)])
        }
    }
    private struct NoteLinkLabel: View {
        @EnvironmentObject var model: 📱AppModel
        @Binding var note: 📗Note
        private var inactive: Bool {
            !self.model.randomMode
            && self.model.notes.first != self.note
        }
        var body: some View {
            VStack(alignment: .leading) {
                Text(self.note.title)
                    .font(.headline)
                    .foregroundStyle(self.inactive ? .secondary : .primary)
                Text(self.note.comment)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

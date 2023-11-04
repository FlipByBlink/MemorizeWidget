import SwiftUI

struct 📚NotesMenu: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        List {
            TextFieldLink {
                Label("New note", systemImage: "plus")
            } onSubmit: {
                self.model.insertOnTop([📗Note($0)])
            }
            ForEach(self.$model.notes) { ⓝote in
                NavigationLink {
                    📗NoteView(ⓝote, .notesMenu)
                } label: {
                    Self.NoteLink(note: ⓝote)
                }
            }
            .onDelete {
                self.model.deleteNote($0)
                💥Feedback.warning()
            }
            .onMove {
                self.model.moveNote($0, $1)
                💥Feedback.light()
            }
        }
        .animation(.default, value: self.model.notes)
        .navigationTitle("Notes")
    }
    private struct NoteLink: View {
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

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
                    Self.NoteLinkLabel(target: ⓝote)
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
        @Binding var target: 📗Note
        private var inactive: Bool {
            !self.model.randomMode
            && 
            self.target != self.model.notes.first
        }
        var body: some View {
            VStack(alignment: .leading) {
                Text(self.target.title)
                    .font(.headline)
                    .foregroundStyle(self.inactive ? .secondary : .primary)
                Text(self.target.comment)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

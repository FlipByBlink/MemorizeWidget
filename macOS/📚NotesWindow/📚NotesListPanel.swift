import SwiftUI

struct 📚NotesListPanel: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        NavigationStack {
            List(selection: self.$model.notesSelection) {
                Section {
                    ForEach(self.$model.notes) {
                        📗NoteView(source: $0)
                    }
                    .onMove { self.model.moveNote($0, $1) }
                    .onDelete { self.model.deleteNoteOnNotesList($0) }
                } footer: {
                    Self.Footer()
                }
            }
            .toolbar { self.newNoteOnTopButton() }
            .navigationTitle("ノート")
            .onDeleteCommand { self.model.removeSelectedNote() }
            .onExitCommand { self.model.clearSelection() }
            .animation(.default, value: self.model.notes)
        }
        .focusedValue(\.notesSelection, self.model.notesSelection)
        .focusedValue(\.notes, self.model.notes)
        .focusedObject(self.model)
        .onOpenURL(perform: self.model.handleWidgetURL)
        .modifier(📰SheetHandlerOnContentView())
        .modifier(📣ADSheet())
        .modifier(💬RequestUserReview())
    }
}

private extension 📚NotesListPanel {
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

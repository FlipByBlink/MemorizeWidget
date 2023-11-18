import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        NavigationStack {
            List(selection: self.$model.notesSelection) {
                Section {
                    ForEach(self.$model.notes) {
                        📗NoteView(note: $0)
                    }
                    .onMove { self.model.moveNote($0, $1) }
                    .onDelete { self.model.deleteNoteOnNotesList($0) }
                } footer: {
                    if self.model.notes.count > 10 {
                        Text("ノート数: \(self.$model.notes.count)")
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            .toolbar { Button { self.model.addNewNoteOnTop() } label: { Label("新規ノート", systemImage: "plus") } }
            .navigationTitle("ノートリスト")
            .onDeleteCommand { self.model.removeSelectedNote() }
            .onExitCommand { self.model.clearSelection() }
            .animation(.default, value: self.model.notes)
        }
        .focusedObject(self.model)
        .frame(minWidth: 360, minHeight: 300)
    }
}

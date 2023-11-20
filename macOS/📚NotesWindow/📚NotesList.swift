import SwiftUI

struct 📚NotesList: View {
    @EnvironmentObject var model: 📱AppModel
    @FocusState private var focusedNoteID: UUID?
    var body: some View {
        List(selection: self.$model.notesSelection) {
            Section {
                ForEach(self.$model.notes) {
                    📗NoteRow(source: $0)
                        .focused(self.$focusedNoteID, equals: $0.id)
                }
                .onMove { self.model.moveNoteForDynamicView($0, $1) }
                .onDelete { self.model.deleteNotesForDynamicView($0) }
            } footer: {
                Self.Footer()
            }
        }
        .toolbar { self.newNoteOnTopButton() }
        .onDeleteCommand { self.model.removeNotesByDeleteCommand() }
        .onExitCommand { self.model.clearSelection() }
        .modifier(Self.NewNoteFocusHandler(state: self._focusedNoteID))
        .animation(.default, value: self.model.notes)
        .contextMenu(forSelectionType: UUID.self) { self.contextMenu($0) }
    }
}

private extension 📚NotesList {
    private struct NewNoteFocusHandler: ViewModifier {
        @EnvironmentObject var model: 📱AppModel
        @FocusState var state: UUID?
        func body(content: Content) -> some View {
            content
                .onChange(of: self.model.createdNewNoteID) {
                    if let ⓝewNoteID = $0 {
                        self.model.clearSelection()
                        self.state = ⓝewNoteID
                        self.model.createdNewNoteID = nil
                    }
                }
        }
    }
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
    private func contextMenu(_ ⓘtems: Set<UUID>) -> some View {
        Group {
            Text(ⓘtems.debugDescription)
            Button("辞書") {}
            Button("検索") {}
            Divider()
            Button("末尾へ移動") {}
            Button("先頭へ移動") {}
            Divider()
            Button("上に新規ノート") {}
            Button("下に新規ノート") {}
        }
    }
}

import SwiftUI

struct 📚NotesList: View {
    @EnvironmentObject var model: 📱AppModel
    @FocusState private var focusedNoteID: UUID?
    var body: some View {
        ScrollViewReader { ⓢcrollViewProxy in
            List(selection: self.$model.notesSelection) {
                Section {
                    ForEach(self.$model.notes) {
                        📗NoteRow(source: $0)
                            .focused(self.$focusedNoteID, equals: $0.id)
                            .id($0.id)
                    }
                    .onMove { self.model.moveNoteForDynamicView($0, $1) }
                    .onDelete(perform: self.onDeleteAction)
                } footer: {
                    Self.Footer()
                }
            }
            .toolbar { 🔝NewNoteOnTopButton() }
            .onDeleteCommand { self.model.removeNotesByDeleteCommand() }
            .onExitCommand { self.model.clearSelection() }
            .onChange(of: self.model.createdNewNoteID) { self.handleNewNoteFocus($0, ⓢcrollViewProxy) }
            .onChange(of: self.focusedNoteID) { if $0 == nil { self.model.saveNotes() } }
            .animation(.default, value: self.model.notes)
            .contextMenu(forSelectionType: UUID.self) { 🚏ContextMenu($0) }
            .overlay { if self.model.notes.isEmpty { Self.emptyView() } }
        }
    }
}

private extension 📚NotesList {
    private var onDeleteAction: Optional<(IndexSet) -> Void> {
        if self.focusedNoteID == nil {
            self.model.deleteNotesForDynamicView
        } else {
            nil
        }
    }
    private func handleNewNoteFocus(_ ⓝewNoteID: UUID?, _ ⓢcrollViewProxy: ScrollViewProxy) {
        if let ⓝewNoteID {
            self.model.clearSelection()
            withAnimation { ⓢcrollViewProxy.scrollTo(ⓝewNoteID) }
            self.focusedNoteID = ⓝewNoteID
            self.model.createdNewNoteID = nil
        }
    }
    private struct Footer: View {
        @EnvironmentObject var model: 📱AppModel
        var body: some View {
            if self.model.notes.count > 10 {
                Text("Notes count: \(self.model.notes.count)")
            }
        }
    }
    private static func emptyView() -> some View {
        VStack {
            Image(systemName: "books.vertical")
            Text("Empty")
        }
        .font(.system(size: 36).bold())
        .fontDesign(.rounded)
        .foregroundStyle(.quaternary)
    }
}

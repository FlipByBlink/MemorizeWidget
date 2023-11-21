import SwiftUI

struct 📚NotesList: View {
    @EnvironmentObject var model: 📱AppModel
    @FocusState private var focusedID: UUID?
    var body: some View {
        ScrollViewReader { ⓢcrollViewProxy in
            List(selection: self.$model.notesSelection) {
                Section {
                    ForEach(self.$model.notes) {
                        📗NoteRow(source: $0)
                            .focused(self.$focusedID, equals: $0.id)
                            .id($0.id)
                    }
                    .onMove { self.model.moveNoteForDynamicView($0, $1) }
                    .onDelete { self.model.deleteNotesForDynamicView($0) }
                } footer: {
                    Self.Footer()
                }
            }
            .toolbar { 🔝NewNoteOnTopButton() }
            .onDeleteCommand { self.model.removeNotesByDeleteCommand() }
            .onExitCommand { self.model.clearSelection() }
            .modifier(Self.NewNoteFocusHandler(self._focusedID, ⓢcrollViewProxy))
            .animation(.default, value: self.model.notes)
            .contextMenu(forSelectionType: UUID.self) { 🚏ContextMenu($0) }
        }
    }
}

private extension 📚NotesList {
    private struct NewNoteFocusHandler: ViewModifier {
        @EnvironmentObject var model: 📱AppModel
        @FocusState var state: UUID?
        var scrollViewProxy: ScrollViewProxy
        func body(content: Content) -> some View {
            content
                .onChange(of: self.model.createdNewNoteID) {
                    if let ⓝewNoteID = $0 {
                        self.model.clearSelection()
                        withAnimation { self.scrollViewProxy.scrollTo(ⓝewNoteID) }
                        self.state = ⓝewNoteID
                        self.model.createdNewNoteID = nil
                    }
                }
        }
        init(_ state: FocusState<UUID?>, _ scrollViewProxy: ScrollViewProxy) {
            self._state = state
            self.scrollViewProxy = scrollViewProxy
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

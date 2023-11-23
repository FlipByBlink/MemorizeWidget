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
                    .onDelete { self.model.deleteNotesForDynamicView($0) }
                } footer: {
                    Self.Footer()
                }
            }
            .toolbar { 🔝NewNoteOnTopButton() }
            .onDeleteCommand { self.model.removeNotesByDeleteCommand() }
            .onExitCommand { self.model.clearSelection() }
            .modifier(Self.NewNoteFocusHandler(self._focusedNoteID, ⓢcrollViewProxy))
            .onChange(of: self.focusedNoteID) { if $0 == nil { self.model.saveNotes() } }
            .animation(.default, value: self.model.notes)
            .contextMenu(forSelectionType: UUID.self) { 🚏ContextMenu($0) }
            .overlay { if self.model.notes.isEmpty { Self.emptyView() } }
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
                Text("Notes count: \(self.model.notes.count)")
            }
        }
    }
    private static func emptyView() -> some View {
        VStack {
            Image(systemName: "books.vertical")
            Text("Empty")
        }
        .font(.system(size: 40).bold())
        .fontDesign(.rounded)
        .foregroundStyle(.quaternary)
    }
}

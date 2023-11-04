import SwiftUI
import WidgetKit

struct 📚NotesListTab: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        NavigationStack {
            ScrollViewReader { ⓢcrollViewProxy in
                List {
                    🔀RandomModeSection()
                    Section {
                        🆕NewNoteOnTopButton()
                        ForEach(self.$model.notes) { ⓝote in
                            📗NoteView(ⓝote, layout: .notesList)
                                .id(ⓝote.id)
                        }
                        .onDelete { self.model.deleteNote($0) }
                        .onMove { self.model.moveNote($0, $1) }
                    } footer: {
                        Text("Notes count: \(self.model.notes.count.description)")
                            .opacity(self.model.notes.count < 6  ? 0 : 1)
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .onChange(of: self.self.model.createdNewNoteID) { ⓢcrollViewProxy.scrollTo($0) }
                .onOpenURL { self.handleNewNoteShortcut($0, ⓢcrollViewProxy) }
                .animation(.default, value: self.model.notes)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                            .disabled(self.model.notes.isEmpty)
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            UISelectionFeedbackGenerator().selectionChanged()
                            self.model.showNotesImportSheet.toggle()
                        } label: {
                            Label("Import notes", systemImage: "tray.and.arrow.down")
                        }
                    }
                }
            }
        }
    }
    private func handleNewNoteShortcut(_ ⓤrl: URL, _ ⓢcrollViewProxy: ScrollViewProxy) {
        if case .newNoteShortcut = 🪧WidgetInfo.load(ⓤrl) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                ⓢcrollViewProxy.scrollTo("NewNoteButton")
                self.model.addNewNoteOnTop()
            }
        }
    }
}

private struct 🔀RandomModeSection: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        Section {
            Toggle(isOn: self.$model.randomMode) {
                Label("Random mode", systemImage: "shuffle")
                    .padding(.vertical, 8)
            }
            .onChange(of: self.model.randomMode) { _ in
                WidgetCenter.shared.reloadAllTimelines()
            }
        } footer: {
            Text("Change the note per 5 minutes.")
        }
    }
}

private struct 🆕NewNoteOnTopButton: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        Button(action: self.model.addNewNoteOnTop) {
            Label("New note", systemImage: "plus")
                .font(.title3.weight(.semibold))
                .padding(.vertical, 7)
        }
        .id("NewNoteButton")
    }
}

struct 🎛️NoteMenuButton: View {
    @Binding private var note: 📗Note
    @State private var dictionaryState: 📘DictionaryState = .default
    var body: some View {
        Menu {
            📘DictionaryItem(self.note, self.$dictionaryState)
            🔍SearchButton(self.note)
            🆕InsertNewNoteBelowButton(self.note)
            🚠MoveSection(self.note)
            Section { 🚮DeleteNoteButton(self.note) }
        } label: {
            Label("Menu", systemImage: "ellipsis.circle")
                .foregroundColor(.secondary)
                .labelStyle(.iconOnly)
                .padding(12)
                .modifier(📘DictionarySheet(self.$dictionaryState))
        }
        .modifier(🩹Workaround.CloseMenePopup())
    }
    init(_ note: Binding<📗Note>) {
        self._note = note
    }
}

private struct 📘DictionaryItem: View {
    private var term: String
    @Binding private var dictionaryState: 📘DictionaryState
    var body: some View {
#if !targetEnvironment(macCatalyst)
            Button {
                self.dictionaryState.request(self.term)
            } label: {
                Label("Dictionary", systemImage: "character.book.closed")
            }
#else
        📘DictionaryButtonOnMac(term: self.term)
#endif
    }
    init(_ note: 📗Note, _ state: Binding<📘DictionaryState>) {
        self.term = note.title
        self._dictionaryState = state
    }
}

private struct 🚠MoveSection: View {
    @EnvironmentObject var model: 📱AppModel
    private var note: 📗Note
    var body: some View {
        Section {
            Button {
                self.model.moveTop(self.note)
            } label: {
                Label("Move top", systemImage: "arrow.up.to.line")
            }
            .disabled(self.model.notes.first == self.note)
            Button {
                self.model.moveEnd(self.note)
            } label: {
                Label("Move end", systemImage: "arrow.down.to.line")
            }
            .disabled(self.model.notes.last == self.note)
        }
    }
    init(_ note: 📗Note) {
        self.note = note
    }
}

private struct 🆕InsertNewNoteBelowButton: View {
    @EnvironmentObject var model: 📱AppModel
    private var note: 📗Note
    var body: some View {
        Button {
            self.model.addNewNoteBelow(self.note)
        } label: {
            Label("New note", systemImage: "text.append")
        }
    }
    init(_ note: 📗Note) {
        self.note = note
    }
}

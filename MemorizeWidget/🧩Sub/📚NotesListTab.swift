import SwiftUI
import WidgetKit

struct 📚NotesListTab: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        NavigationView {
            ScrollViewReader { 🚡 in
                List {
                    🗑TrashMenu()
                    🚩RandomModeSection()
                    Section {
                        🆕NewNoteOnTopButton()
                        ForEach($📱.📚notes) { ⓝote in
                            HStack(spacing: 0) {
                                📓NoteView(ⓝote)
                                🎛️NoteMenuButton(ⓝote)
                            }
                        }
                        .onDelete(perform: 📱.delete(_:))
                        .onMove { 📱.📚notes.move(fromOffsets: $0, toOffset: $1) }
                    } footer: {
                        Text("Notes count: \(📱.📚notes.count.description)")
                            .opacity(📱.📚notes.count < 6  ? 0 : 1)
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .onOpenURL { self.ⓗandleNewNoteShortcut($0, 🚡) }
                .animation(.default, value: 📱.📚notes)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                            .disabled(📱.📚notes.isEmpty)
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            UISelectionFeedbackGenerator().selectionChanged()
                            📱.🚩showNotesImportSheet.toggle()
                        } label: {
                            Label("Import notes", systemImage: "tray.and.arrow.down")
                        }
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
    }
    private func ⓗandleNewNoteShortcut(_ ⓤrl: URL, _ 🚡: ScrollViewProxy) {
        if case .newNoteShortcut = 🪧WidgetInfo.load(ⓤrl) {
            🚡.scrollTo("NewNoteButton")
            📱.addNewNoteOnTop()
        }
    }
}

private struct 🚩RandomModeSection: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        Section {
            Toggle(isOn: $📱.🚩randomMode) {
                Label("Random mode", systemImage: "shuffle")
                    .padding(.vertical, 8)
            }
            .task(id: 📱.🚩randomMode) { WidgetCenter.shared.reloadAllTimelines() }
        } footer: {
            Text("Change the note per 5 minutes.")
        }
    }
}

private struct 🆕NewNoteOnTopButton: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        Button(action: 📱.addNewNoteOnTop) {
            Label("New note", systemImage: "plus")
                .font(.title3.weight(.semibold))
                .padding(.vertical, 7)
        }
        .id("NewNoteButton")
    }
}

private struct 🎛️NoteMenuButton: View {
    @EnvironmentObject var 📱: 📱AppModel
    @Binding private var ⓝote: 📗Note
    @State private var 📘dictionaryState: 📘DictionaryState = .default
    var body: some View {
        Menu {
            📘DictionaryItem(self.ⓝote, self.$📘dictionaryState)
            🔍SearchButton(self.ⓝote)
            🆕InsertNewNoteBelowButton(self.ⓝote)
            Section { 🗑DeleteNoteButton(self.ⓝote) }
        } label: {
            Label("Menu", systemImage: "ellipsis.circle")
                .foregroundColor(.secondary)
                .labelStyle(.iconOnly)
                .padding(12)
        }
        .modifier(📘DictionarySheet(self.$📘dictionaryState))
        .modifier(🩹Workaround.closeMenePopup())
    }
    init(_ note: Binding<📗Note>) {
        self._ⓝote = note
    }
}

private struct 📘DictionaryItem: View {
    private var ⓣerm: String
    @Binding private var ⓢtate: 📘DictionaryState
    var body: some View {
        Button {
            self.ⓢtate.request(self.ⓣerm)
        } label: {
            Label("Dictionary", systemImage: "character.book.closed")
        }
    }
    init(_ note: 📗Note, _ state: Binding<📘DictionaryState>) {
        self.ⓣerm = note.title
        self._ⓢtate = state
    }
}

private struct 🆕InsertNewNoteBelowButton: View {
    @EnvironmentObject var 📱: 📱AppModel
    private var ⓝote: 📗Note
    var body: some View {
        Button {
            guard let ⓘndex = 📱.📚notes.firstIndex(of: self.ⓝote) else { return }
            📱.addNewNote(ⓘndex + 1)
        } label: {
            Label("New note", systemImage: "text.append")
        }
    }
    init(_ note: 📗Note) {
        self.ⓝote = note
    }
}

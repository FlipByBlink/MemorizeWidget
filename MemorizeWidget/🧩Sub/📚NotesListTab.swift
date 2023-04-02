import SwiftUI
import WidgetKit

struct 📚NotesListTab: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        NavigationView {
            ScrollViewReader { 🚡 in
                List {
                    self.🚩randomModeSection()
                    Section {
                        self.🆕newNoteButton()
                            .onOpenURL { self.ⓗandleNewNoteShortcut($0, 🚡) }
                        ForEach($📱.📚notes) { ⓝote in
                            HStack(spacing: 0) {
                                📓NoteView(ⓝote)
                                🎛️NoteMenuButton(ⓝote)
                            }
                        }
                        .onDelete { 📱.📚notes.remove(atOffsets: $0) }
                        .onMove { 📱.📚notes.move(fromOffsets: $0, toOffset: $1) }
                    } footer: {
                        Text("Notes count: \(📱.📚notes.count.description)")
                            .opacity(📱.📚notes.count < 6  ? 0 : 1)
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
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
    private func 🚩randomModeSection() -> some View {
        Section {
            Toggle(isOn: self.$📱.🚩randomMode) {
                Label("Random mode", systemImage: "shuffle")
                    .padding(.vertical, 8)
            }
            .onChange(of: 📱.🚩randomMode) { _ in
                WidgetCenter.shared.reloadAllTimelines()
            }
        } footer: {
            Text("Change the note per 5 minutes.")
        }
    }
    private func 🆕newNoteButton() -> some View {
        Button {
            📱.addNewNote()
        } label: {
            Label("New note", systemImage: "plus")
                .font(.title3.weight(.semibold))
                .padding(.vertical, 7)
        }
        .disabled(📱.📚notes.first?.isEmpty == true)
        .id("NewNoteButton")
    }
    private func ⓗandleNewNoteShortcut(_ ⓤrl: URL, _ 🚡: ScrollViewProxy) {
        if ⓤrl.description == "NewNoteShortcut" {
            🚡.scrollTo("NewNoteButton")
        }
    }
}

private struct 🎛️NoteMenuButton: View {
    @EnvironmentObject var 📱: 📱AppModel
    @Binding private var ⓝote: 📗Note
    @State private var 🚩showDictionarySheet: Bool = false
    var body: some View {
        Menu {
            📗DictionaryItem(self.$🚩showDictionarySheet)
            🔍SearchButton(self.ⓝote)
            🆕InsertNewNoteButton(self.ⓝote)
            Section { 🗑DeleteNoteButton(self.ⓝote) }
        } label: {
            Label("Menu", systemImage: "ellipsis.circle")
                .foregroundColor(.secondary)
                .labelStyle(.iconOnly)
                .padding(12)
        }
        .modifier(📗DictionarySheet(self.ⓝote, self.$🚩showDictionarySheet))
        .modifier(🩹Workaround.closeMenePopup())
    }
    init(_ note: Binding<📗Note>) {
        self._ⓝote = note
    }
}

private struct 📗DictionaryItem: View {
    @Binding private var 🚩showSheet: Bool
    var body: some View {
        Button {
            self.🚩showSheet = true
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        } label: {
            Label("Dictionary", systemImage: "character.book.closed")
        }
    }
    init(_ showSheet: Binding<Bool>) {
        self._🚩showSheet = showSheet
    }
}

private struct 🆕InsertNewNoteButton: View {
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
    init(_ ⓝote: 📗Note) {
        self.ⓝote = ⓝote
    }
}

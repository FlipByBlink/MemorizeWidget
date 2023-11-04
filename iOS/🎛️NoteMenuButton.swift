import SwiftUI

struct 🎛️NoteMenuButton: View {
    @Binding private var note: 📗Note
    @State private var dictionaryState: 📘DictionaryState = .default
    var body: some View {
        Menu {
            Self.DictionaryButton(self.note, self.$dictionaryState)
            🔍SearchButton(self.note)
            Self.InsertNewNoteBelowButton(self.note)
            Self.MoveButtons(self.note)
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

private extension 🎛️NoteMenuButton {
    private struct DictionaryButton: View {
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
    private struct InsertNewNoteBelowButton: View {
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
    private struct MoveButtons: View {
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
}

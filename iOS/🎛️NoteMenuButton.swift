import SwiftUI

struct 🎛️NoteMenuButton: View {
    @EnvironmentObject var model: 📱AppModel
    @Binding private var note: 📗Note
    var body: some View {
        Menu {
            self.dictionaryButton()
            🔍SearchButton(self.note)
            self.insertNewNoteBelowButton()
            self.moveButtons()
            Section { 🚮DeleteNoteButton(self.note) }
        } label: {
            Label("Menu", systemImage: "ellipsis.circle")
                .foregroundColor(.secondary)
                .labelStyle(.iconOnly)
                .padding(12)
        }
        .modifier(🩹Workaround.CloseMenePopup())
    }
    init(_ note: Binding<📗Note>) {
        self._note = note
    }
}

private extension 🎛️NoteMenuButton {
    private func dictionaryButton() -> some View {
#if !targetEnvironment(macCatalyst)
        Button {
            self.model.presentedSheetOnContentView = .dictionary(.init(term: self.note.title))
        } label: {
            Label("Dictionary", systemImage: "character.book.closed")
        }
#else
        📘DictionaryButtonOnMac(term: self.term)
#endif
    }
    private func insertNewNoteBelowButton() -> some View {
        Button {
            self.model.addNewNoteBelow(self.note)
        } label: {
            Label("New note", systemImage: "text.append")
        }
    }
    private func moveButtons() -> some View {
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
}

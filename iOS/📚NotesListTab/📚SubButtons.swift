import SwiftUI

struct 📚SubButtons: View {
    @EnvironmentObject var model: 📱AppModel
    @Binding private var note: 📗Note
    var body: some View {
        HStack {
            if self.isIPad {
                self.dictionaryButton()
                🔍SearchButton(self.note, padding: 8)
            }
            Menu {
                if !self.isIPad {
                    self.dictionaryButton()
                    🔍SearchButton(self.note)
                }
                self.insertNewNoteBelowButton()
                self.moveButtons()
                Section { 🚮DeleteNoteButton(self.note) }
            } label: {
                Label("Menu", systemImage: "ellipsis.circle")
                    .padding(8)
            }
            .hoverEffect()
            .modifier(🩹Workaround.CloseMenePopup())
        }
        .padding(4)
        .foregroundStyle(Color.secondary)
        .labelStyle(.iconOnly)
        .buttonStyle(.plain)
    }
    init(_ note: Binding<📗Note>) {
        self._note = note
    }
}

private extension 📚SubButtons {
    private var isIPad: Bool { UIDevice.current.userInterfaceIdiom == .pad }
    private func dictionaryButton() -> some View {
#if !targetEnvironment(macCatalyst)
        Button {
            self.model.presentedSheetOnContentView = .dictionary(.init(term: self.note.title))
            UISelectionFeedbackGenerator().selectionChanged()
        } label: {
            Label("Dictionary", systemImage: "character.book.closed")
                .padding(8)
        }
        .hoverEffect()
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

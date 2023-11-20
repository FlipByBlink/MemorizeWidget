import SwiftUI

struct 🪄Commands: Commands {
    @FocusedObject var model: 📱AppModel?
    @FocusedValue(\.notes) var notes
    @FocusedValue(\.notesSelection) var notesSelection
    @FocusedValue(\.editingNote) var editingNote
    var body: some Commands {
        🛒InAppPurchaseCommand()
        CommandGroup(replacing: .systemServices) { EmptyView() }
        CommandGroup(after: .newItem) {
            Self.OpenNotesWindowButton()
        }
        CommandMenu("Notes") {
            self.newNoteOnTopButton()
            Divider()
            self.newNoteAboveButton()
            self.newNoteBelowButton()
            Divider()
            self.moveTopButton()
            self.moveEndButton()
            Divider()
            self.dictionaryButton()
            self.searchButton()
            Divider()
            Self.OpenTrashWindowButton()
            Divider()
            self.deleteAllNotesButton()
        }
        ℹ️HelpCommands()
    }
}

private extension 🪄Commands {
    private struct OpenNotesWindowButton: View {
        @Environment(\.openWindow) var openWindow
        var body: some View {
            Button("Open main window") {
                self.openWindow(id: "notes")
            }
        }
    }
    private func newNoteOnTopButton() -> some View {
        Button("New note on top") {
            self.model?.insertNewNoteOnTop()
        }
        .keyboardShortcut("n")
    }
    private func newNoteAboveButton() -> some View {
        Button("Insert new note above") {
            self.model?.insertAbove()
        }
        .keyboardShortcut("[")
        .disabled(
            (self.notesSelection?.count != 1)
            ||
            (self.notesSelection?.first == self.notes?.first?.id)
        )
    }
    private func newNoteBelowButton() -> some View {
        Button("Insert new note below") {
            self.model?.insertBelow()
        }
        .keyboardShortcut("]")
        .disabled(
            (self.notesSelection?.count != 1)
            ||
            (self.notesSelection?.first == self.notes?.last?.id)
        )
    }
    private func moveTopButton() -> some View {
        Button("Move top") {
            let ⓝote = self.model?.notes.first { $0.id == self.model?.notesSelection.first }
            if let ⓝote {
                self.model?.moveTop(ⓝote)
            }
        }
        .keyboardShortcut("t")
        .disabled(
            (self.notesSelection?.isEmpty == true)
            ||
            (self.notesSelection?.first == self.notes?.first?.id)
        )
    }
    private func moveEndButton() -> some View {
        Button("Move end") {
            let ⓝote = self.model?.notes.first { $0.id == self.model?.notesSelection.first }
            if let ⓝote {
                self.model?.moveEnd(ⓝote)
            }
        }
        .keyboardShortcut("e")
        .disabled(
            (self.notesSelection?.isEmpty == true)
            ||
            (self.notesSelection?.first == self.notes?.last?.id)
        )
    }
    private func dictionaryButton() -> some View {
        Button("Look up the title in dictionaries") {
        }
        .keyboardShortcut("d")
        .disabled(self.notesSelection?.count != 1)
    }
    private func searchButton() -> some View {
        Button("Search the title") {
        }
        .keyboardShortcut("s")
        .disabled(self.notesSelection?.count != 1)
    }
    private struct OpenTrashWindowButton: View {
        @Environment(\.openWindow) var openWindow
        var body: some View {
            Button("Open trash") {
                self.openWindow(id: "trash")
            }
        }
    }
    private func deleteAllNotesButton() -> some View {
        Button("Delete all notes") {
            self.model?.removeAllNotes()
        }
        .disabled(self.notes?.isEmpty == true)
    }
}

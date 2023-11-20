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
    private var targetNotes: Set<📗Note> {
        if let editingNote {
            [editingNote]
        } else {
            if let notes, let notesSelection {
                .init(notes.filter { notesSelection.contains($0.id) })
            } else {
                []
            }
        }
    }
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
            self.model?.insertAbove(self.targetNotes)
        }
        .keyboardShortcut("[")
        .disabled(self.targetNotes.count != 1)
    }
    private func newNoteBelowButton() -> some View {
        Button("Insert new note below") {
            self.model?.insertBelow(self.targetNotes)
        }
        .keyboardShortcut("]")
        .disabled(self.targetNotes.count != 1)
    }
    private func moveTopButton() -> some View {
        Button("Move top") {
            self.model?.moveTop(self.targetNotes)
        }
        .keyboardShortcut("t")
        .disabled(
            self.targetNotes.isEmpty
            ||
            self.targetNotes.contains { $0 == self.notes?.first }
        )
    }
    private func moveEndButton() -> some View {
        Button("Move end") {
            self.model?.moveEnd(self.targetNotes)
        }
        .keyboardShortcut("e")
        .disabled(
            self.targetNotes.isEmpty
            ||
            self.targetNotes.contains { $0 == self.notes?.last }
        )
    }
    private func dictionaryButton() -> some View {
        Button("Look up the title in dictionaries") {
        }
        .keyboardShortcut("d")
        .disabled(self.targetNotes.count != 1)
    }
    private func searchButton() -> some View {
        Button("Search the title") {
        }
        .keyboardShortcut("s")
        .disabled(self.targetNotes.count != 1)
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
        .disabled(self.targetNotes.isEmpty)
    }
}

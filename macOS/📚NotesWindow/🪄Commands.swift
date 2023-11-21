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
            Divider()
            🔝NewNoteOnTopButton()
                .keyboardShortcut("n")
            Divider()
            👆InsertAboveButton(self.targetNotes)
                .keyboardShortcut("[")
            👇InsertBelowButton(self.targetNotes)
                .keyboardShortcut("]")
        }
        CommandGroup(before: .undoRedo) {
            🛫MoveTopButton(self.targetNotes)
                .keyboardShortcut("t")
            🛬MoveEndButton(self.targetNotes)
                .keyboardShortcut("e")
            Divider()
        }
        CommandGroup(after: .textEditing) {
            🚮DeleteAllNotesButton()
        }
        CommandMenu("Action") {
            📘DictionaryButton(self.targetNotes)
                .keyboardShortcut("d")
            🔍SearchButton(self.targetNotes)
                .keyboardShortcut("s")
        }
        CommandMenu("Organize") {
            Group {
                Button("Import notes") { self.model?.presentedSheetOnContentView = .notesImport }
                Button("Export notes") { self.model?.presentedSheetOnContentView = .notesExport }
            }
            .disabled(self.model?.presentedSheetOnContentView != nil)
            Divider()
            Self.OpenTrashWindowButton()
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
        @FocusedValue(\.openedMainWindow) var openedMainWindow
        var body: some View {
            Button("Open main window") {
                self.openWindow(id: "notes")
            }
            .disabled(self.openedMainWindow == true)
        }
    }
    private struct OpenTrashWindowButton: View {
        @Environment(\.openWindow) var openWindow
        var body: some View {
            Button("Open trash") {
                self.openWindow(id: "trash")
            }
        }
    }
}

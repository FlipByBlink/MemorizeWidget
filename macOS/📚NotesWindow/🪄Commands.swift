import SwiftUI

struct 🪄Commands: Commands {
    @FocusedObject var model: 📱AppModel?
    @FocusedValue(\.notes) var notes
    @FocusedValue(\.notesSelection) var notesSelection
    @FocusedValue(\.editingNote) var editingNote
    @FocusedValue(\.openedMainWindow) var openedMainWindow
    @FocusedValue(\.presentedSheetOnContentView) var presentedSheetOnContentView
    @Environment(\.openWindow) var openWindow
    var body: some Commands {
        🛒InAppPurchaseCommand()
        ℹ️HelpCommands()
        CommandGroup(replacing: .systemServices) {
            EmptyView()
        }
        CommandGroup(after: .newItem) {
            self.openMainWindowButton()
        }
        if self.activeNotesPanel {
            CommandGroup(after: .newItem) {
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
                    Button("Import notes(file)") {
                        self.model?.presentSheet(.notesImportFile)
                    }
                    Button("Import notes(text)") {
                        self.model?.presentSheet(.notesImportText)
                    }
                    Button("Export notes") {
                        self.model?.presentSheet(.notesExport)
                    }
                }
                Divider()
                Button("Open trash") {
                    self.openWindow(id: "trash")
                }
            }
        }
    }
}

private extension 🪄Commands {
    private var activeNotesPanel: Bool {
        (self.openedMainWindow == true)
        &&
        (self.presentedSheetOnContentView == nil)
    }
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
    private func openMainWindowButton() -> some View {
        Button("Open main window") {
            self.openWindow(id: "notes")
        }
        .disabled(self.openedMainWindow == true)
    }
}

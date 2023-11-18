import SwiftUI

struct 🪄Commands: Commands {
//    @ObservedObject var model: 📱AppModel
    var body: some Commands {
//        🛒InAppPurchaseCommand()
        CommandGroup(replacing: .systemServices) { EmptyView() }
        CommandGroup(after: .newItem) {
            Self.OpenNotesWindowButton()
        }
        CommandMenu("Notes") {
            Self.NewNoteOnTopButton()
            Self.NewNoteOnEndButton()
            Divider()
            Self.NewNoteAboveButton()
            Self.NewNoteBelowButton()
            Divider()
            Self.MoveTopButton()
            Self.MoveEndButton()
            Divider()
            Self.DictionaryButton()
            Self.SearchButton()
        }
//        ℹ️HelpCommands()
    }
//    init(_ model: 📱AppModel) {
//        self.model = model
//    }
}

private extension 🪄Commands {
    private struct OpenNotesWindowButton: View {
        @Environment(\.openWindow) var openWindow
        var body: some View {
            Button("Open notes") {
                self.openWindow(id: "notes")
            }
        }
    }
    private struct NewNoteOnTopButton: View {
        @FocusedObject var model: 📱AppModel?
        var body: some View {
            Button("New note on top") {
                self.model?.addNewNoteOnTop()
            }
            .keyboardShortcut("n")
        }
    }
    private struct NewNoteOnEndButton: View {
        @FocusedObject var model: 📱AppModel?
        var body: some View {
            Button("New note on end") {
                self.model?.addNewNoteOnTop()
            }
            .keyboardShortcut("n", modifiers: [.command, .shift])
        }
    }
    private struct NewNoteAboveButton: View {
        @FocusedObject var model: 📱AppModel?
        var body: some View {
            Button("Insert new note above") {
                self.model?.insertAbove()
            }
            .keyboardShortcut("[")
            .disabled(self.model?.notesSelection.count != 1)
        }
    }
    private struct NewNoteBelowButton: View {
        @FocusedObject var model: 📱AppModel?
        var body: some View {
            Button("Insert new note below") {
                self.model?.insertBelow()
            }
            .keyboardShortcut("]")
            .disabled(self.model?.notesSelection.count != 1)
        }
    }
    private struct MoveTopButton: View {
        @FocusedObject var model: 📱AppModel?
        var body: some View {
            Button("Move top") {
                let ⓝote = self.model?.notes.first { $0.id == self.model?.notesSelection.first }
                if let ⓝote {
                    self.model?.moveTop(ⓝote)
                }
            }
            .keyboardShortcut("t")
            .disabled(self.model?.notesSelection.first == self.model?.notes.first?.id)
        }
    }
    private struct MoveEndButton: View {
        @FocusedObject var model: 📱AppModel?
        var body: some View {
            Button("Move end") {
                let ⓝote = self.model?.notes.first { $0.id == self.model?.notesSelection.first }
                if let ⓝote {
                    self.model?.moveEnd(ⓝote)
                }
            }
            .keyboardShortcut("e")
            .disabled(self.model?.notesSelection.first == self.model?.notes.last?.id)
        }
    }
    private struct DictionaryButton: View {
        @FocusedObject var model: 📱AppModel?
        var body: some View {
            Button("Look up the title in dictionaries") {
            }
            .keyboardShortcut("d")
            .disabled(self.model?.notesSelection != nil)
        }
    }
    private struct SearchButton: View {
        @FocusedObject var model: 📱AppModel?
        var body: some View {
            Button("Search the title") {
            }
            .keyboardShortcut("s")
            .disabled(self.model?.notesSelection != nil)
        }
    }
}

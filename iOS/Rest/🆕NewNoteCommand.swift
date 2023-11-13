import SwiftUI

struct 🆕NewNoteCommand: Commands {
    @ObservedObject var model: 📱AppModel
    var body: some Commands {
        CommandGroup(replacing: .newItem) {
            Button {
                self.model.addNewNoteOnTop()
            } label: {
                Text("New note")
            }
            .keyboardShortcut("n")
            .disabled(self.model.selectedSidebar != .notesList)
        }
    }
    init(_ model: 📱AppModel) {
        self.model = model
    }
}

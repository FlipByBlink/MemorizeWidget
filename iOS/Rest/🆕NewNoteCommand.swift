import SwiftUI

struct 🆕NewNoteCommand: Commands {
    @ObservedObject var 📱: 📱AppModel
    var body: some Commands {
        CommandGroup(replacing: .newItem) {
            Button {
                📱.addNewNoteOnTop()
            } label: {
                Text("New note")
            }
            .keyboardShortcut("n")
        }
    }
    init(_ 📱: 📱AppModel) {
        self.📱 = 📱
    }
}

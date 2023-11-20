import SwiftUI

struct 📘DictionaryButton: View {
    @EnvironmentObject var model: 📱AppModel
    @Environment(\.openURL) var openURL
    var body: some View {
        Button {
            let ⓝote = self.model.notes.first { $0.id == self.model.notesSelection.first }
            guard let ⓟath = ⓝote?.title.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed),
                  let ⓤrl = URL(string: "dict://" + ⓟath) else {
                NSSound.beep()
                return
            }
            self.openURL(ⓤrl)
        } label: {
            Label("Dictionary", systemImage: "character.book.closed")
        }
    }
}

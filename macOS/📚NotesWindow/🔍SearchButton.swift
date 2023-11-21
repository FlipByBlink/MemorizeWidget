import SwiftUI

struct 🔍SearchButton: View { //MARK: WIP
    @Environment(\.openURL) var openURL
    private var notes: Set<📗Note>
    var body: some View {
        Button {
            guard let ⓝote = self.notes.first,
                  let ⓟath = ⓝote.title.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed),
                  let ⓤrl = URL(string: "https://duckduckgo.com/?q=" + ⓟath) else {
                NSSound.beep()
                return
            }
            self.openURL(ⓤrl)
        } label: {
            Label("Search the title", systemImage: "character.book.closed")
        }
        .disabled(self.notes.count != 1)
    }
    init(_ notes: Set<📗Note>) {
        self.notes = notes
    }
}

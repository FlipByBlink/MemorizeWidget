import SwiftUI

struct 📘DictionaryButtonOnMac: View {
    @Environment(\.openURL) var openURL
    var term: String
    var body: some View {
        Button {
            guard let ⓟath = self.term.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed),
                  let ⓤrl = URL(string: "dict://" + ⓟath) else {
                return
            }
            self.openURL(ⓤrl)
        } label: {
            Label("Dictionary", systemImage: "character.book.closed")
        }
    }
}

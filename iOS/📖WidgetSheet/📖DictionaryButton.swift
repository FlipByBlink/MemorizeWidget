import SwiftUI

struct 📖DictionaryButton: View {
    private var term: String
    @State private var dictionaryState: 📘DictionaryState = .default
    var body: some View {
#if !targetEnvironment(macCatalyst)
        Button {
            self.dictionaryState.request(self.term)
        } label: {
            Label("Dictionary", systemImage: "character.book.closed")
        }
        .modifier(📘DictionarySheet(self.$dictionaryState))
#else
        📘DictionaryButtonOnMac(term: self.term)
#endif
    }
    init(_ note: 📗Note) {
        self.term = note.title
    }
}

import SwiftUI

struct 📖DictionaryButton: View {
    @EnvironmentObject var model: 📱AppModel
    private var term: String
    var body: some View {
#if !targetEnvironment(macCatalyst)
        Button {
            self.model.presentedSheetOnWidgetSheet = .dictionary(.init(term: self.term))
        } label: {
            Label("Dictionary", systemImage: "character.book.closed")
        }
#else
        📘DictionaryButtonOnMac(term: self.term)
#endif
    }
    init(_ note: 📗Note) {
        self.term = note.title
    }
}

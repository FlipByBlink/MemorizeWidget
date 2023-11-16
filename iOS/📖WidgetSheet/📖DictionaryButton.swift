import SwiftUI

struct 📖DictionaryButton: View {
    @EnvironmentObject var model: 📱AppModel
    private var term: String
    var body: some View {
#if !targetEnvironment(macCatalyst)
        Button {
            self.model.presentedSheetOnWidgetSheet = .dictionary(.init(term: self.term))
            UISelectionFeedbackGenerator().selectionChanged()
        } label: {
            Label("Dictionary", systemImage: "character.book.closed")
                .padding(8)
        }
        .hoverEffect()
#else
        📘DictionaryButtonOnMac(term: self.term)
#endif
    }
    init(_ ⓝote: 📗Note) {
        self.term = ⓝote.title
    }
}

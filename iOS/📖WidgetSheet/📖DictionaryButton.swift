import SwiftUI

struct 📖DictionaryButton: View {
    @EnvironmentObject var model: 📱AppModel
    private var term: String
    var body: some View {
        Button {
            self.model.presentedSheetOnWidgetSheet = .dictionary(.init(term: self.term))
            UISelectionFeedbackGenerator().selectionChanged()
        } label: {
            Label("Dictionary", systemImage: "character.book.closed")
                .padding(8)
        }
        .hoverEffect()
    }
    init(_ ⓝote: 📗Note) {
        self.term = ⓝote.title
    }
}

import SwiftUI

struct 🔍SearchButton: View {
    @EnvironmentObject var model: 📱AppModel
    @AppStorage("SearchLeadingText") var inputtedLeadingText: String = ""
    @AppStorage("SearchTrailingText") var trailingText: String = ""
    private var query: String
    private var padding: CGFloat
    var body: some View {
        Button(action: self.action) {
            Label("Search", systemImage: "magnifyingglass")
                .padding(self.padding)
        }
        .hoverEffect()
    }
    init(_ note: 📗Note, padding: CGFloat = 0) {
        self.query = note.title
        self.padding = padding
    }
}

private extension 🔍SearchButton {
    private func action() {
        let ⓛeadingText = if self.inputtedLeadingText.isEmpty {
            "https://duckduckgo.com/?q="
        } else {
            self.inputtedLeadingText
        }
        let ⓣext = ⓛeadingText + self.query + self.trailingText
        guard let ⓔncodedText = ⓣext.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        guard let ⓤrl = URL(string: ⓔncodedText) else { return }
        💥Feedback.light()
        self.model.presentSheet(.search(.init(url: ⓤrl)))
    }
}

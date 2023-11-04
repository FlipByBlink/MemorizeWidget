import SwiftUI

struct 🔍SearchButton: View {
    @Environment(\.openURL) var openURL
    @AppStorage("SearchLeadingText") var inputtedLeadingText: String = ""
    @AppStorage("SearchTrailingText") var trailingText: String = ""
    private var query: String
    var body: some View {
        Button(action: self.action) {
            Label("Search", systemImage: "magnifyingglass")
        }
    }
    init(_ note: 📗Note) {
        self.query = note.title
    }
    private func action() {
        let ⓛeadingText = if self.inputtedLeadingText.isEmpty {
            "https://duckduckgo.com/?q="
        } else {
            self.inputtedLeadingText
        }
        let ⓣext = ⓛeadingText + self.query + self.trailingText
        guard let ⓔncodedText = ⓣext.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        guard let ⓤrl = URL(string: ⓔncodedText) else { return }
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        self.openURL(ⓤrl)
    }
}

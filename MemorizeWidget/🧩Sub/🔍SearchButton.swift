import SwiftUI

struct 🔍SearchButton: View {
    @Environment(\.openURL) var openURL
    @AppStorage("SearchLeadingText") var 🔗leading: String = ""
    @AppStorage("SearchTrailingText") var 🔗trailing: String = ""
    private var ⓠuery: String
    var body: some View {
        Button {
            self.ⓐction()
        } label: {
            Label("Search", systemImage: "magnifyingglass")
                .padding(8)
        }
    }
    private func ⓐction() {
        let ⓛeading = self.🔗leading.isEmpty ? "https://duckduckgo.com/?q=" : self.🔗leading
        let ⓣext = ⓛeading + self.ⓠuery + self.🔗trailing
        guard let ⓔncodedText = ⓣext.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        guard let ⓤrl = URL(string: ⓔncodedText) else { return }
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        self.openURL(ⓤrl)
    }
    init(_ note: 📗Note) {
        self.ⓠuery = note.title
    }
}

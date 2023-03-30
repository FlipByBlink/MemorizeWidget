import SwiftUI

struct 🔍SearchButton: View {
    @EnvironmentObject var 📱: 📱AppModel
    @AppStorage("SearchLeadingText") var 🔗leading: String = ""
    @AppStorage("SearchTrailingText") var 🔗trailing: String = ""
    @Environment(\.openURL) var openURL
    private var 🔢noteIndex: Int
    var body: some View {
        Button {
            self.ⓐction()
        } label: {
            Label("Search", systemImage: "magnifyingglass")
                .labelStyle(.iconOnly)
        }
    }
    private func ⓐction() {
        let ⓛeading = self.🔗leading.isEmpty ? "https://duckduckgo.com/?q=" : self.🔗leading
        let ⓣext = ⓛeading + 📱.📚notes[self.🔢noteIndex].title + self.🔗trailing
        guard let ⓔncodedText = ⓣext.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        guard let ⓤrl = URL(string: ⓔncodedText) else { return }
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        self.openURL(ⓤrl)
    }
    init(_ noteIndex: Int) {
        self.🔢noteIndex = noteIndex
    }
}

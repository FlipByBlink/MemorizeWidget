import SwiftUI
import SafariServices

struct 🔍SearchButton: View {
    @EnvironmentObject var model: 📱AppModel
    @StateObject private var searchModel: 🔍SearchModel = .init()
    private var query: String
    private var padding: CGFloat
    var body: some View {
        Button {
            let ⓤrl = self.searchModel.generateURL(self.query)
            self.model.presentSheet(.search(ⓤrl))
        } label: {
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

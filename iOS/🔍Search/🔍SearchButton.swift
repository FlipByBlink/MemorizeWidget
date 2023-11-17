import SwiftUI

struct 🔍SearchButton: View {
    @EnvironmentObject var appModel: 📱AppModel
    @StateObject private var searchModel: 🔍SearchModel = .init()
    @Environment(\.openURL) var openURL
    private var query: String
    private var padding: CGFloat
    var body: some View {
        Button {
            let ⓤrl = self.searchModel.generateURL(self.query)
            if self.searchModel.openURLInOtherApp {
                self.openURL(ⓤrl)
            } else {
                self.appModel.presentSheet(.search(ⓤrl))
            }
        } label: {
            Label("Search", systemImage: "magnifyingglass")
                .padding(self.padding)
        }
        .disabled(!self.searchModel.ableInAppSearch)
        .hoverEffect()
    }
    init(_ ⓝote: 📗Note, padding: CGFloat = 0) {
        self.query = ⓝote.title
        self.padding = padding
    }
}

import SwiftUI

struct 📖SearchButton: View {
    @EnvironmentObject var appModel: 📱AppModel
    @StateObject private var searchModel: 🔍SearchModel = .init()
    private var query: String
    var body: some View {
        Button {
            let ⓤrl = self.searchModel.generateURL(self.query)
            self.appModel.presentedSheetOnWidgetSheet = .search(ⓤrl)
            UISelectionFeedbackGenerator().selectionChanged()
        } label: {
            Label("Search", systemImage: "magnifyingglass")
        }
        .hoverEffect()
    }
    init(_ ⓝote: 📗Note) {
        self.query = ⓝote.title
    }
}

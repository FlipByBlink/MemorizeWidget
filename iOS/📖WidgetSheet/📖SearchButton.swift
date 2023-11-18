import SwiftUI

struct 📖SearchButton: View {
    @EnvironmentObject var appModel: 📱AppModel
    @StateObject var searchModel: 🔍SearchModel = .init()
    @Environment(\.openURL) var openURL
    private var query: String
    var body: some View {
        Button {
            let ⓤrl = self.searchModel.generateURL(self.query)
            if self.searchModel.openURLInOtherApp {
                self.openURL(ⓤrl) {
                    if $0 == false { self.searchModel.alertOpenURLFailure = true }
                }
            } else {
                self.appModel.presentedSheetOnWidgetSheet = .search(ⓤrl)
            }
            UISelectionFeedbackGenerator().selectionChanged()
        } label: {
            Label("Search", systemImage: "magnifyingglass")
                .padding(8)
        }
        .disabled(!self.searchModel.ableInAppSearch)
        .hoverEffect()
        .modifier(🔍FailureAlert(self.searchModel))
    }
    init(_ ⓝote: 📗Note) {
        self.query = ⓝote.title
    }
}

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        🏢RootView()
            .onOpenURL(perform: self.model.handleWidgetURL)
            .modifier(📰SheetHandlerOnContentView())
            .modifier(💬RequestUserReview())
            .environmentObject(self.model.inAppPurchaseModel)
    }
}

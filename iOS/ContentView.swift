import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        🔖TabView()
            .onOpenURL(perform: self.model.handleWidgetURL)
            .modifier(💬RequestUserReview())
            .modifier(🩹Workaround.HideTitleBarOnMacCatalyst())
            .modifier(📰SheetOnContentView.Handler())
            .environmentObject(self.model.inAppPurchaseModel)
    }
}

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        Group {
            switch UIDevice.current.userInterfaceIdiom {
                case .phone: 🔖TabView()
                case .pad: 🔖SplitView()
                default: EmptyView()
            }
        }
        .onOpenURL(perform: self.model.handleWidgetURL)
        .modifier(📰SheetHandlerOnContentView())
        .modifier(💬RequestUserReview())
        .environmentObject(self.model.inAppPurchaseModel)
    }
}

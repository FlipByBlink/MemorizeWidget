import SwiftUI

struct 🛒InAppPurchaseWindow: Scene {
    var body: some Scene {
        Window(.init("In-App Purchase", tableName: "🌐AD&InAppPurchase"), id: "InAppPurchase") {
            Self.ContentView()
        }
        .defaultSize(width: 400, height: 700)
        .commandsRemoved()
    }
    private struct ContentView: View {
        @EnvironmentObject var appModel: 📱AppModel
        var body: some View {
            🛒InAppPurchaseMenu()
                .environmentObject(self.appModel.inAppPurchaseModel)
        }
    }
}

import SwiftUI

@main
struct IOSApp: App {
    @StateObject private var appModel = 📱AppModel()
    @StateObject private var inAppPurchaseModel = 🛒InAppPurchaseModel(id: "MemorizeWidget.adfree")
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(self.appModel)
                .environmentObject(self.inAppPurchaseModel)
        }
        .commands {
            🆕NewNoteCommand(self.appModel)
        }
    }
}

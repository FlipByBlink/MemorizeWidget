import SwiftUI

@main
struct iOSApp: App {
    @StateObject private var 📱 = 📱AppModel()
    @StateObject private var 🛒 = 🛒InAppPurchaseModel(id: "MemorizeWidget.adfree")
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(📱)
                .environmentObject(🛒)
        }
        .commands {
            🆕NewNoteCommand(📱)
        }
    }
}

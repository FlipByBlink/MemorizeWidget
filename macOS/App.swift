import SwiftUI

@main
struct MacOSApp: App {
    @NSApplicationDelegateAdaptor var model: 📱AppModel
    var body: some Scene {
        Window("Notes", id: "notes") {
            ContentView()
        }
        .defaultSize(width: 360, height: 240)
        .commands { 🪄Commands() }
        🏗️MenuBarShortcut(self.model)
        🔧Settings(self.model)
        ℹ️HelpWindows()
        🛒InAppPurchaseWindow()
    }
}

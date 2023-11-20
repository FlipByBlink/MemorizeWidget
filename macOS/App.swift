import SwiftUI

@main
struct MacOSApp: App {
    @NSApplicationDelegateAdaptor var model: 📱AppModel
    var body: some Scene {
        📚NotesWindow()
            .commands { 🪄Commands() }
        🗑TrashWindow()
        🏗️MenuBarShortcut(self.model)
        🔧Settings(self.model)
        ℹ️HelpWindows()
        🛒InAppPurchaseWindow()
    }
}

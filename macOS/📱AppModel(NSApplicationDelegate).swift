import SwiftUI

extension 📱AppModel: NSApplicationDelegate {
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        false
    }
    func applicationDidResignActive(_ notification: Notification) {
        self.saveNotes(withWidgetReload: false)
    }
    func application(_ application: NSApplication, open urls: [URL]) {
        if let ⓤrl = urls.first {
            self.handleWidgetURL(ⓤrl)
        }
    }
}

import SwiftUI

@main
struct MacOSApp: App {
    @StateObject private var model = 📱AppModel()
    var body: some Scene {
        Window("Notes", id: "notes") {
            ContentView()
                .environmentObject(self.model)
        }
        .commands { 🪄Commands() }
        🏗️MenuBarShortcut(self.model)
        🔧Settings(self.model)
    }
}

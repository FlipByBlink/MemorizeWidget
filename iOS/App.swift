import SwiftUI

@main
struct IOSApp: App {
    @StateObject private var appModel = 📱AppModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(self.appModel)
        }
        .commands {
            🆕NewNoteCommand(self.appModel)
        }
    }
}

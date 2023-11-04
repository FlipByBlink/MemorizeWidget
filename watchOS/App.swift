import SwiftUI

@main
struct WatchOSApp: App {
    @StateObject private var model = 📱AppModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(self.model)
        }
    }
}

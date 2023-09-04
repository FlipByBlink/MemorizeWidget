import SwiftUI

@main
struct watchOSApp: App {
    private let 📱 = 📱AppModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(📱)
        }
    }
}

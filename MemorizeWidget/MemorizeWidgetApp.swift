
import SwiftUI

@main
struct MemorizeWidgetApp: App {
    let 📱 = 📱AppModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(📱)
        }
    }
}

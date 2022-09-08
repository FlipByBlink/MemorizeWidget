
import SwiftUI

@main
struct MemorizeWidgetApp: App {
    let 📱 = 📱AppModel()
    let 🛒 = 🛒StoreModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(📱)
                .environmentObject(🛒)
        }
    }
}

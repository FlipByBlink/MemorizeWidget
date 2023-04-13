import SwiftUI

@main
struct MemorizeWidgetApp: App {
    @StateObject private var 📱 = 📱AppModel()
    @StateObject private var 🛒 = 🛒StoreModel(id: "MemorizeWidget.adfree")
    
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

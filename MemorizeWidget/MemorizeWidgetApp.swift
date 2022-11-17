
import SwiftUI
import WidgetKit

@main
struct MemorizeWidgetApp: App {
    @StateObject private var 📱 = 📱AppModel()
    @StateObject private var 🛒 = 🛒StoreModel(id: "MemorizeWidget.adfree")
    @Environment(\.scenePhase) var ⓢcenePhase: ScenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(📱)
                .environmentObject(🛒)
                .onChange(of: ⓢcenePhase) { ⓝewValue in
                    if ⓝewValue == .active {
                        let ⓢtockNotes = 📚ShareExtensionManeger.takeOutNotes()
                        if !ⓢtockNotes.isEmpty {
                            📱.🗃Notes.insert(contentsOf: ⓢtockNotes, at: 0)
                        }
                    }
                }
                .onChange(of: 📱.🗃Notes) { _ in
                    📱.💾SaveNotes()
                    WidgetCenter.shared.reloadAllTimelines()
                }
        }
    }
}

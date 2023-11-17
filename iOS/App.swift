import SwiftUI

@main
struct IOSApp: App {
    @StateObject private var model = 📱AppModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(self.model)
                .task {
                    self.model.presentedSheetOnContentView = .customizeSearch
                }
        }
        .commands {
            🆕NewNoteCommand(self.model)
        }
    }
}

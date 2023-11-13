import SwiftUI

@main
struct IOSApp: App {
    @StateObject private var model = 📱AppModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(self.model)
                .task { self.model.presentedSheetOnContentView = .customizeSearch } //DEBUG
        }
        .commands {
            🆕NewNoteCommand(self.model)
        }
    }
}

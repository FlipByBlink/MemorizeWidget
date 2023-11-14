import SwiftUI

@main
struct IOSApp: App {
    @StateObject private var model = 📱AppModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(self.model)
                .task {
                    self.model.selectedSidebar = .option
                    self.model.selectedTab = .option
                }//MARK: DEBUG
        }
        .commands {
            🆕NewNoteCommand(self.model)
        }
    }
}

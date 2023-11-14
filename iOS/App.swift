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
                .sheet(isPresented: .constant(true)) {
                    NavigationStack {
                        🎛️FontSizeOptionMenu()
                    }
                }
        }
        .commands {
            🆕NewNoteCommand(self.model)
        }
    }
}

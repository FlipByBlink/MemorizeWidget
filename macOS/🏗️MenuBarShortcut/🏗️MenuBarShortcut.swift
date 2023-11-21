import SwiftUI

struct 🏗️MenuBarShortcut: Scene {
    @ObservedObject var model: 📱AppModel
    @AppStorage(🎛️Key.showMenuBar) var showMenuBar: Bool = true
    var body: some Scene {
        MenuBarExtra("New note",
                     systemImage: "square.and.pencil",
                     isInserted: self.$showMenuBar) {
            🏗️ContentView(self.model)
        }
        .menuBarExtraStyle(.window)
    }
    init(_ model: 📱AppModel) {
        self.model = model
    }
}

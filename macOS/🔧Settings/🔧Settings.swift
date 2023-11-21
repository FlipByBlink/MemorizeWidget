import SwiftUI

struct 🔧Settings: Scene {
    private var model: 📱AppModel
    var body: some Scene {
        Settings {
            TabView {
                🔧GeneralPanel()
                🔧FontSizePanel()
                🔧SearchCustomizePanel()
                🔧GuidePanel()
            }
            .frame(width: 540, height: 400)
            .environmentObject(self.model)
        }
        .windowResizability(.contentSize)
        .defaultPosition(.init(x: 0.1, y: 0.1))
    }
    init(_ model: 📱AppModel) {
        self.model = model
    }
}

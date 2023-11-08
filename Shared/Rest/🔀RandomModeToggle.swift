import SwiftUI
import WidgetKit

struct 🔀RandomModeToggle: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        Toggle(isOn: self.$model.randomMode) {
            Label("Random mode", systemImage: "shuffle")
        }
        .onChange(of: self.model.randomMode) { _ in
            WidgetCenter.shared.reloadAllTimelines()
        }
    }
}

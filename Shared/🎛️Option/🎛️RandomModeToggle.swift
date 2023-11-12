import SwiftUI
import WidgetKit

struct 🎛️RandomModeToggle: View {
    @EnvironmentObject var model: 📱AppModel
#if os(iOS)
    @Environment(\.editMode) var editMode
#endif
    var body: some View {
        Toggle(isOn: self.$model.randomMode) {
            Label("Random mode", systemImage: "shuffle")
        }
        .onChange(of: self.model.randomMode) { _ in
            WidgetCenter.shared.reloadAllTimelines()
        }
#if os(iOS)
        .disabled(self.editMode?.wrappedValue == .active)
#endif
    }
    struct Caption: View {
        var body: some View {
            Text("Change the note per 5 minutes.")
        }
    }
}

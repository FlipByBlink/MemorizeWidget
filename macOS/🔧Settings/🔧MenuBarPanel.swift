import SwiftUI

struct 🔧MenuBarPanel: View {
    @AppStorage(🎛️Key.showMenuBar) var value: Bool = true
    var body: some View {
        Form {
            Toggle(isOn: self.$value) {
                Label("New note shortcut on menu bar",
                      systemImage: "menubar.arrow.up.rectangle")
            }
        }
        .tabItem {
            Label("MenuBar", systemImage: "menubar.arrow.up.rectangle")
        }
    }
}

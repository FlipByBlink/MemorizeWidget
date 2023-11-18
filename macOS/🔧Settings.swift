import SwiftUI

struct 🔧Settings: Scene {
    var body: some Scene {
        Settings {
            TabView {
                Form {
                    Self.MenuBarShortcutToggle()
                    Toggle("Toggle", isOn: .constant(false))
                    Picker("Picker", selection: .constant(1)) {
                        Text("1").tag(1); Text("2").tag(2); Text("3").tag(3);
                    }
                    Link("Link", destination: URL(string: "http://apple.com")!)
                }
                .padding(24)
                .tabItem { Label("1", systemImage: "1.circle") }
                Text("2")
                    .tabItem { Label("2", systemImage: "2.circle") }
            }
            .frame(width: 400, height: 250)
        }
        .windowResizability(.contentSize)
    }
}

private extension 🔧Settings {
    private struct MenuBarShortcutToggle: View {
        @AppStorage("showMenuBar") var showMenuBar: Bool = true
        var body: some View {
            Toggle(isOn: self.$showMenuBar) {
                Label("Menubar shortcut", systemImage: "menubar.arrow.up.rectangle")
            }
        }
    }
}

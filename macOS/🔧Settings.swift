import SwiftUI

struct 🔧Settings: Scene {
    var model: 📱AppModel
    var body: some Scene {
        Settings {
            TabView {
                Form {
                    Section {
                        🎛️RandomModeToggle()
                    } footer: {
                        🎛️RandomModeToggle.Caption()
                    }
                    🎛️ViewComponent.MultiNotesToggle()
                    🎛️ViewComponent.ShowCommentToggle()
                }
                .formStyle(.grouped)
                .tabItem { Label("Widget", systemImage: "rectangle.3.group") }
                Form {
                    Self.MenuBarShortcutToggle()
                }
                .padding(24)
                .tabItem { Label("App", systemImage: "app") }
                Form {
                    Text("Placeholder")
                }
                .padding(24)
                .tabItem { Label("Search", systemImage: "magnifyingglass") }
            }
            .frame(width: 400, height: 250)
            .environmentObject(self.model)
        }
        .windowResizability(.contentSize)
        .defaultPosition(.init(x: 0.1, y: 0.1))
    }
    init(_ model: 📱AppModel) {
        self.model = model
    }
}

private extension 🔧Settings {
    private struct MenuBarShortcutToggle: View {
        @AppStorage(🎛️Key.showMenuBar) var value: Bool = true
        var body: some View {
            Toggle(isOn: self.$value) {
                Label("Menubar shortcut", systemImage: "menubar.arrow.up.rectangle")
            }
        }
    }
}

import SwiftUI

struct 🔧GeneralPanel: View {
    var body: some View {
        Form {
            Spacer()
            Section {
                🎛️RandomModeToggle()
            } footer: {
                🎛️RandomModeToggle.Caption()
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Section {
                🎛️ViewComponent.MultiNotesToggle()
                🎛️ViewComponent.ShowCommentToggle()
            }
            Spacer()
            Self.MenuBarShortcutToggle()
            Spacer()
        }
        .padding(32)
        .tabItem {
            Label("General", systemImage: "rectangle.3.group")
        }
    }
}

private extension 🔧GeneralPanel {
    private struct MenuBarShortcutToggle: View {
        @AppStorage(🎛️Key.showMenuBar) var value: Bool = true
        var body: some View {
            Toggle(isOn: self.$value) {
                Label("Menubar shortcut", systemImage: "menubar.arrow.up.rectangle")
            }
        }
    }
}

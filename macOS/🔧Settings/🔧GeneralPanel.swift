import SwiftUI

struct 🔧GeneralPanel: View {
    var body: some View {
        Form {
            Section {
                🎛️RandomModeToggle()
            } footer: {
                🎛️RandomModeToggle.Caption()
            }
            Section {
                🎛️ViewComponent.MultiNotesToggle()
                🎛️ViewComponent.ShowCommentToggle()
                🎛️ViewComponent.MultilineTextAlignmentPicker()
            } header: {
                Text("Widget")
            }
            Self.MenuBarShortcutToggle()
        }
        .formStyle(.grouped)
        .tabItem {
            Label("General", systemImage: "rectangle.3.group")
        }
    }
}

private extension 🔧GeneralPanel {
    private struct MenuBarShortcutToggle: View {
        @AppStorage(🎛️Key.showMenuBar) var value: Bool = true
        var body: some View {
            Section {
                Toggle(isOn: self.$value) {
                    Label("Menu bar shortcut", 
                          systemImage: "menubar.arrow.up.rectangle")
                }
            } header: {
                Text("Rest")
            }
        }
    }
}

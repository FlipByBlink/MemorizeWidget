import SwiftUI

struct 🔧Settings: Scene {
    private var model: 📱AppModel
    var body: some Scene {
        Settings {
            TabView {
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
                Form {
                    Spacer()
                    🎛️ViewComponent.FontSize.CustomizeToggle()
                        .labelStyle(.titleOnly)
                        .toggleStyle(.switch)
                    Spacer()
                    🎛️ViewComponent.FontSize.TitleForSystemFamilyPicker()
                    🎛️ViewComponent.FontSize.CommentForSystemFamilyPicker()
                    Spacer()
                }
                .padding(96)
                .tabItem {
                    Label("Font", systemImage: "textformat.size")
                }
                Form {
                    Text("Placeholder")
                }
                .padding(24)
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                Form {
                    💁GuideViewComponent.AboutDataSync()
                    💁GuideViewComponent.AboutDataCount()
                }
                .formStyle(.grouped)
                .tabItem {
                    Label("Guide", systemImage: "questionmark")
                }
            }
            .frame(width: 400, height: 300)
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

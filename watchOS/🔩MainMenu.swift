import SwiftUI

struct 🔩MainMenu: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        List {
            Self.randomModeSection()
            Section {
                🎛️ViewComponent.MultiNotesToggle()
                Self.CommentOnWidgetSection()
                Self.fontSizeMenuLink()
            } header: {
                Text("Widget")
            }
            self.trashMenuLink()
            Self.deleteAllNotesButton()
        }
        .navigationTitle("Menu")
    }
}

private extension 🔩MainMenu {
    private static func randomModeSection() -> some View {
        Section {
            🎛️RandomModeToggle()
        } footer: {
            🎛️RandomModeToggle.Caption()
        }
    }
    private struct CommentOnWidgetSection: View {
        @AppStorage(🎛️Key.multiNotesMode, store: .ⓐppGroup) var multiNotesMode: Bool = false
        var body: some View {
            🎛️ViewComponent.ShowCommentToggle()
                .disabled(self.multiNotesMode)
        }
    }
    private func trashMenuLink() -> some View {
        Section {
            NavigationLink {
                🗑TrashMenu()
            } label: {
                LabeledContent {
                    Text(verbatim: "\(self.model.trash.deletedContents.count)")
                } label: {
                    Label("Trash", systemImage: "trash")
                }
            }
        }
    }
    private static func fontSizeMenuLink() -> some View {
        Section {
            NavigationLink {
                🎛️FontSizeMenu()
            } label: {
                Label("Customize font size", systemImage: "textformat.size")
            }
        }
    }
    private static func deleteAllNotesButton() -> some View {
        Section {
            🚮DeleteAllNotesButton()
                .modifier(🚮DeleteAllNotesButton.ConfirmDialog())
        }
    }
}

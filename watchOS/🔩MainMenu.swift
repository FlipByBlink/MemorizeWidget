import SwiftUI

struct 🔩MainMenu: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        List {
            self.randomModeSection()
            Section {
                🎛️ViewComponent.MultiNotesToggle()
                Self.CommentOnWidgetSection()
            } header: {
                Text("Widget")
            }
            self.trashMenuLink()
            self.deleteAllNotesButton()
        }
        .navigationTitle("Menu")
    }
}

private extension 🔩MainMenu {
    private func randomModeSection() -> some View {
        Section {
            🎛️RandomModeToggle()
        } footer: {
            🎛️RandomModeToggle.Caption()
        }
    }
    private struct CommentOnWidgetSection: View {
        @AppStorage("multiNotes", store: .ⓐppGroup) var multiNotesMode: Bool = false
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
    private func deleteAllNotesButton() -> some View {
        Section {
            🚮DeleteAllNotesButton()
                .modifier(🚮DeleteAllNotesButton.ConfirmDialog())
        }
    }
}

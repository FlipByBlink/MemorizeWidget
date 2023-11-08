import SwiftUI

struct 🔩MainMenu: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        List {
            self.randomModeSection()
            Section {
                🔩MenuViewComponent.MultiNotesToggle()
                Self.CommentOnWidgetSection()
            } header: {
                Text("Widget")
            }
            Section { self.trashMenuLink() }
            Section { 🚮DeleteAllNotesButton() }
        }
        .navigationTitle("Menu")
    }
}

private extension 🔩MainMenu {
    private func randomModeSection() -> some View {
        Section {
            🔀RandomModeToggle()
        } footer: {
            🔀RandomModeToggle.Caption()
        }
    }
    private struct CommentOnWidgetSection: View {
        @AppStorage("multiNotes", store: .ⓐppGroup) var multiNotesMode: Bool = false
        var body: some View {
            🔩MenuViewComponent.ShowCommentToggle()
                .disabled(self.multiNotesMode)
        }
    }
    private func trashMenuLink() -> some View {
        NavigationLink {
            🗑TrashMenu()
        } label: {
            LabeledContent {
                Text("\(self.model.trash.deletedContents.count)")
            } label: {
                Label("Trash", systemImage: "trash")
            }
        }
    }
}

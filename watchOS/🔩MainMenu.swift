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
            Section { Self.DeleteAllNotesButton() }
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
    private struct DeleteAllNotesButton: View {
        @EnvironmentObject var model: 📱AppModel
        @State private var showDialog: Bool = false
        var body: some View {
            Section {
                Button(role: .destructive) {
                    self.showDialog = true
                } label: {
                    Label("Delete all notes.", systemImage: "delete.backward.fill")
                }
                .disabled(self.model.notes.isEmpty)
                .confirmationDialog("Delete all notes.", isPresented: self.$showDialog) {
                    Button(role: .destructive) {
                        self.model.removeAllNotes()
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }
        }
    }
}

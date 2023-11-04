import SwiftUI
import WidgetKit

struct 🔩MainMenu: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        List {
            self.randomModeSection()
            Section {
                Self.MultiNotesOption()
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
            Toggle(isOn: self.$model.randomMode) {
                Label("Random mode", systemImage: "shuffle")
            }
            .onChange(of: self.model.randomMode) { _ in
                WidgetCenter.shared.reloadAllTimelines()
            }
        } footer: {
            Text("Change the note per 5 minutes.")
        }
    }
    private struct MultiNotesOption: View {
        @AppStorage("multiNotes", store: .ⓐppGroup) var value: Bool = false
        var body: some View {
            Toggle(isOn: self.$value) {
                Label("Show multi notes", systemImage: "doc.on.doc")
            }
            .onChange(of: self.value) { _ in
                WidgetCenter.shared.reloadAllTimelines()
            }
        }
    }
    private struct CommentOnWidgetSection: View {
        @AppStorage("ShowComment", store: .ⓐppGroup) var value: Bool = false
        @AppStorage("multiNotes", store: .ⓐppGroup) var multiNotesMode: Bool = false
        var body: some View {
            Toggle(isOn: self.$value) {
                Label("Show comment", systemImage: "text.append")
            }
            .disabled(self.multiNotesMode)
            .onChange(of: self.value) { _ in
                WidgetCenter.shared.reloadAllTimelines()
            }
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

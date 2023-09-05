import SwiftUI
import WidgetKit

struct 🔩MainMenu: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        List {
            self.randomModeSection()
            Section {
                Self.MultiNotesOption()
                Self.CommentOnWidgetSection()
            } header: {
                Text("Widget")
            }
            Section { 🗑TrashMenuLink() }
            Section { Self.DeleteAllNotesButton() }
        }
        .navigationTitle("Menu")
    }
}

private extension 🔩MainMenu {
    private func randomModeSection() -> some View {
        Section {
            Toggle(isOn: $📱.🚩randomMode) {
                Label("Random mode", systemImage: "shuffle")
            }
            .onChange(of: 📱.🚩randomMode) { _ in
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
        @AppStorage("ShowComment", store: .ⓐppGroup) var 🚩value: Bool = false
        @AppStorage("multiNotes", store: .ⓐppGroup) var ⓜultiNotes: Bool = false
        var body: some View {
            Toggle(isOn: self.$🚩value) {
                Label("Show comment", systemImage: "text.append")
            }
            .disabled(self.ⓜultiNotes)
            .onChange(of: self.🚩value) { _ in
                WidgetCenter.shared.reloadAllTimelines()
            }
        }
    }
    private struct DeleteAllNotesButton: View {
        @EnvironmentObject var 📱: 📱AppModel
        @State private var showDialog: Bool = false
        var body: some View {
            Section {
                Button(role: .destructive) {
                    self.showDialog = true
                } label: {
                    Label("Delete all notes.", systemImage: "delete.backward.fill")
                }
                .disabled(📱.📚notes.isEmpty)
                .confirmationDialog("Delete all notes.", isPresented: self.$showDialog) {
                    Button(role: .destructive) {
                        📱.removeAllNotes()
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }
        }
    }
}

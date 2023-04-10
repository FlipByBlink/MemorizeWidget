import SwiftUI
import WidgetKit

struct 🔩Menu: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        List {
            🔀RandomModeSection()
            📑MultiNotesOption()
            💬CommentOnWidgetSection()
            Section { 🗑TrashLink() }
            Section { 🚮DeleteAllNotesButton() }
        }
        .navigationTitle("Menu")
    }
}

private struct 🔀RandomModeSection: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        Section {
            Toggle(isOn: $📱.🚩randomMode) {
                Label("Random mode", systemImage: "shuffle")
            }
            .task(id: 📱.🚩randomMode) { WidgetCenter.shared.reloadAllTimelines() }
        } footer: {
            Text("Change the note per 5 minutes.")
        }
    }
}

private struct 📑MultiNotesOption: View {
    @AppStorage("multiNotes", store: .ⓐppGroup) var 🚩value: Bool = false
    var body: some View {
        Toggle(isOn: self.$🚩value) {
            Label("Show multi notes on widget", systemImage: "doc.on.doc")
        }
        .task(id: self.🚩value) { WidgetCenter.shared.reloadAllTimelines() }
    }
}

private struct 💬CommentOnWidgetSection: View {
    @AppStorage("ShowComment", store: .ⓐppGroup) var 🚩value: Bool = false
    @AppStorage("multiNotes", store: .ⓐppGroup) var ⓜultiNotes: Bool = false
    var body: some View {
        Toggle(isOn: self.$🚩value) {
            Label("Show comment on widget", systemImage: "text.append")
        }
        .task(id: self.🚩value) { WidgetCenter.shared.reloadAllTimelines() }
        .disabled(self.ⓜultiNotes)
    }
}

private struct 🗑TrashLink: View {
    var body: some View {
        NavigationLink {
            🗑TrashMenu()
        } label: {
            Label("Trash", systemImage: "trash")
        }
    }
}

private struct 🗑TrashMenu: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        List {
            ForEach(📱.🗑trash.deletedContents) {
                self.ⓒontentSection($0)
            }
            self.ⓔmptyTrashView()
            self.ⓐboutTrashSection()
            self.ⓒlearButton()
        }
        .navigationTitle("Trash")
        .animation(.default, value: 📱.🗑trash.deletedContents)
    }
    private func ⓒontentSection(_ ⓒontent: 🄳eletedContent) -> some View {
        Section {
            if ⓒontent.notes.count == 1 {
                self.ⓢingleNoteRow(ⓒontent)
            } else {
                self.ⓜultiNotesRows(ⓒontent)
            }
        } header: {
            Text(ⓒontent.date, style: .offset)
            +
            Text(" (\(ⓒontent.date.formatted(.dateTime.month().day().hour().minute())))")
        }
    }
    private func ⓢingleNoteRow(_ ⓒontent: 🄳eletedContent) -> some View {
        HStack {
            self.ⓝoteView(ⓒontent.notes.first ?? .init("🐛"))
            Spacer()
            self.ⓡestoreButton(ⓒontent)
                .labelStyle(.iconOnly)
                .buttonStyle(.plain)
                .font(.title)
                .symbolRenderingMode(.hierarchical)
                .foregroundColor(.secondary)
                .padding(4)
        }
    }
    private func ⓜultiNotesRows(_ ⓒontent: 🄳eletedContent) -> some View {
        Group {
            self.ⓡestoreButton(ⓒontent)
                .font(.body.weight(.medium))
            ForEach(ⓒontent.notes) { self.ⓝoteView($0) }
        }
    }
    private func ⓝoteView(_ ⓝote: 📗Note) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(ⓝote.title)
                    .font(.body.weight(.semibold))
                Text(ⓝote.comment)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding(4)
        }
    }
    private func ⓡestoreButton(_ ⓒontent: 🄳eletedContent) -> some View {
        Button {
            📱.restore(ⓒontent)
        } label: {
            Label("Restore \(ⓒontent.notes.count.description) notes",
                  systemImage: "arrow.uturn.backward.circle.fill")
            .padding(.vertical, 4)
        }
        .accessibilityLabel("Restore")
    }
    private func ⓒlearButton() -> some View {
        Button(role: .destructive) {
            📱.🗑trash.clearDeletedContents()
        } label: {
            Label("Clear trash", systemImage: "trash.slash")
        }
        .tint(.red)
        .disabled(📱.🗑trash.deletedContents.isEmpty)
    }
    private func ⓔmptyTrashView() -> some View {
        Group {
            if 📱.🗑trash.deletedContents.isEmpty {
                ZStack {
                    Color.clear
                    Label("Empty", systemImage: "xmark.bin")
                        .font(.title2)
                        .foregroundStyle(.secondary)
                }
                .padding(32)
                .listRowBackground(Color.clear)
            }
        }
    }
    private func ⓐboutTrashSection() -> some View {
        Section {
            Label("After 7 days, the notes will be permanently deleted.",
                  systemImage: "clock.badge.exclamationmark")
            Label("Trash do not sync with iCloud.", systemImage: "xmark.icloud")
        }
        .font(.subheadline)
        .foregroundStyle(.secondary)
        .listRowBackground(Color.clear)
    }
}

private struct 🚮DeleteAllNotesButton: View {
    @EnvironmentObject var 📱: 📱AppModel
    @State private var 🚩showDialog: Bool = false
    var body: some View {
        Section {
            Button(role: .destructive) {
                self.🚩showDialog = true
            } label: {
                Label("Delete all notes.", systemImage: "delete.backward.fill")
            }
            .disabled(📱.📚notes.isEmpty)
            .confirmationDialog("Delete all notes.", isPresented: self.$🚩showDialog) {
                Button(role: .destructive, action: 📱.removeAllNotes) {
                    Label("Delete", systemImage: "trash")
                }
            }
        }
    }
}

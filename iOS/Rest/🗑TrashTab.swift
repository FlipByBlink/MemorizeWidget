import SwiftUI

struct 🗑TrashTab: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        NavigationStack {
            List {
                ForEach(self.model.trash.deletedContents) {
                    self.contentSection($0)
                }
                self.emptyTrashView()
                🗑TrashViewComponent.AboutSection()
            }
            .navigationTitle("Trash")
            .toolbar { self.clearButton() }
            .animation(.default, value: self.model.trash.deletedContents)
        }
    }
}

private extension 🗑TrashTab {
    private func contentSection(_ ⓒontent: 🗑DeletedContent) -> some View {
        Section {
            if ⓒontent.notes.count == 1 {
                self.singleNoteRow(ⓒontent)
            } else {
                self.multiNotesRows(ⓒontent)
            }
        } header: {
            🗑TrashViewComponent.DateText(source: ⓒontent)
        }
    }
    private func singleNoteRow(_ ⓒontent: 🗑DeletedContent) -> some View {
        HStack {
            self.noteView(ⓒontent.notes.first ?? .init("BUG"))
            Spacer()
            self.restoreButton(ⓒontent)
                .labelStyle(.iconOnly)
                .buttonStyle(.plain)
                .font(.title)
                .symbolRenderingMode(.hierarchical)
                .foregroundColor(.secondary)
                .padding(4)
        }
    }
    private func multiNotesRows(_ ⓒontent: 🗑DeletedContent) -> some View {
        Group {
            self.restoreButton(ⓒontent)
                .font(.body.weight(.medium))
            ForEach(ⓒontent.notes) { self.noteView($0) }
        }
    }
    private func noteView(_ ⓝote: 📗Note) -> some View {
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
    private func restoreButton(_ ⓒontent: 🗑DeletedContent) -> some View {
        🗑TrashViewComponent.RestoreButton(source: ⓒontent)
            .padding(.vertical, 4)
    }
    private func clearButton() -> some View {
        Menu {
            🗑TrashViewComponent.ClearButton()
        } label: {
            Label("Clear trash", systemImage: "trash.slash")
        }
        .tint(.red)
        .disabled(self.model.trash.deletedContents.isEmpty)
    }
    private func emptyTrashView() -> some View {
        Group {
            if self.model.trash.deletedContents.isEmpty {
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
}

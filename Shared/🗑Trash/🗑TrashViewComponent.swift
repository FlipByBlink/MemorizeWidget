import SwiftUI

enum 🗑TrashViewComponent {
    struct DateText: View {
        var source: 🗑DeletedContent
        var body: some View {
            Text(self.source.date, style: .offset)
            +
            Text(" (\(self.source.date.formatted(.dateTime.month().day().hour().minute())))")
        }
    }
    struct RestoreButton: View {
        @EnvironmentObject var model: 📱AppModel
        var source: 🗑DeletedContent
        var body: some View {
            Button {
                self.model.restore(self.source)
            } label: {
                Label("Restore \(self.source.notes.count) notes",
                      systemImage: "arrow.uturn.backward.circle.fill")
            }
            .accessibilityLabel("Restore")
        }
    }
    struct ClearButton: View {
        @EnvironmentObject var model: 📱AppModel
        var body: some View {
            Button(role: .destructive) {
                self.model.trash.clearDeletedContents()
            } label: {
                Label("Clear trash", systemImage: "trash.slash")
            }
            .tint(.red)
            .disabled(self.model.trash.deletedContents.isEmpty)
        }
    }
    struct AboutSection: View {
        var body: some View {
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
}

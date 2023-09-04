import SwiftUI

struct 📗NoteView: View {
    @EnvironmentObject var 📱: 📱AppModel
    @Environment(\.dismiss) var dismiss
    @Binding var ⓝote: 📗Note
    private var ⓚind: Self.🄺ind = .notesMenu
    var body: some View {
        List {
            TextField("Title", text: self.$ⓝote.title)
                .font(.headline)
            TextField("Comment", text: self.$ⓝote.comment)
                .font(.caption)
                .foregroundStyle(.secondary)
            switch self.ⓚind {
                case .notesMenu:
                    self.ⓜoveSectionOnNotesMenu()
                    self.ⓡemoveButton()
                case .notesSheet:
                    if 📱.🚩randomMode {
                        self.ⓡemoveButton()
                    } else {
                        self.ⓜoveEndButtonOnNotesSheet()
                        self.ⓡemoveButton()
                    }
            }
        }
    }
    enum 🄺ind {
        case notesMenu, notesSheet
    }
    init(_ note: Binding<📗Note>, _ kind: Self.🄺ind) {
        self._ⓝote = note
        self.ⓚind = kind
    }
}

private extension 📗NoteView {
    private func ⓡemoveButton() -> some View {
        Button(role: .destructive) {
            📱.removeNote(self.ⓝote)
            self.dismiss()
        } label: {
            Label("Delete", systemImage: "trash")
        }
    }
    private func ⓜoveSectionOnNotesMenu() -> some View {
        HStack {
            Button {
                📱.moveTop(self.ⓝote)
                self.dismiss()
            } label: {
                Label("Move top", systemImage: "arrow.up.to.line.circle.fill")
                    .labelStyle(.iconOnly)
                    .symbolRenderingMode(.hierarchical)
                    .font(.title2)
            }
            .buttonStyle(.plain)
            .disabled(self.ⓝote.id == 📱.📚notes.first?.id)
            Spacer()
            Text("Move")
                .font(.headline)
                .foregroundStyle(📱.📚notes.count <= 1 ? .tertiary : .primary)
            Spacer()
            Button {
                📱.moveEnd(self.ⓝote)
                self.dismiss()
            } label: {
                Label("Move end", systemImage: "arrow.down.to.line.circle.fill")
                    .labelStyle(.iconOnly)
                    .symbolRenderingMode(.hierarchical)
                    .font(.title2)
            }
            .buttonStyle(.plain)
            .disabled(self.ⓝote.id == 📱.📚notes.last?.id)
        }
    }
    private func ⓜoveEndButtonOnNotesSheet() -> some View {
        Button {
            📱.moveEnd(self.ⓝote)
        } label: {
            Label("Move end", systemImage: "arrow.down.to.line")
        }
        .disabled(self.ⓝote.id == 📱.📚notes.last?.id)
    }
}

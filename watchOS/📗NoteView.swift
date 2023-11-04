import SwiftUI

struct 📗NoteView: View {
    @EnvironmentObject var model: 📱AppModel
    @Environment(\.dismiss) var dismiss
    @Binding private var note: 📗Note
    private var kind: Self.Kind = .notesMenu
    var body: some View {
        List {
            TextField("Title", text: self.$note.title)
                .font(.headline)
            TextField("Comment", text: self.$note.comment)
                .font(.caption)
                .foregroundStyle(.secondary)
            switch self.kind {
                case .notesMenu:
                    self.moveSectionOnNotesMenu()
                    self.removeButton()
                case .notesSheet:
                    if self.model.randomMode {
                        self.removeButton()
                    } else {
                        self.moveEndButtonOnNotesSheet()
                        self.removeButton()
                    }
            }
        }
    }
    enum Kind {
        case notesMenu, notesSheet
    }
    init(_ note: Binding<📗Note>, _ kind: Self.Kind) {
        self._note = note
        self.kind = kind
    }
}

private extension 📗NoteView {
    private func removeButton() -> some View {
        Button(role: .destructive) {
            self.model.removeNote(self.note)
            self.dismiss()
        } label: {
            Label("Delete", systemImage: "trash")
        }
    }
    private func moveSectionOnNotesMenu() -> some View {
        HStack {
            Button {
                self.model.moveTop(self.note)
                self.dismiss()
            } label: {
                Label("Move top", systemImage: "arrow.up.to.line.circle.fill")
                    .labelStyle(.iconOnly)
                    .symbolRenderingMode(.hierarchical)
                    .font(.title2)
            }
            .buttonStyle(.plain)
            .disabled(self.note.id == self.model.notes.first?.id)
            Spacer()
            Text("Move")
                .font(.headline)
                .foregroundStyle(self.model.notes.count <= 1 ? .tertiary : .primary)
            Spacer()
            Button {
                self.model.moveEnd(self.note)
                self.dismiss()
            } label: {
                Label("Move end", systemImage: "arrow.down.to.line.circle.fill")
                    .labelStyle(.iconOnly)
                    .symbolRenderingMode(.hierarchical)
                    .font(.title2)
            }
            .buttonStyle(.plain)
            .disabled(self.note.id == self.model.notes.last?.id)
        }
    }
    private func moveEndButtonOnNotesSheet() -> some View {
        Button {
            self.model.moveEnd(self.note)
        } label: {
            Label("Move end", systemImage: "arrow.down.to.line")
        }
        .disabled(self.note.id == self.model.notes.last?.id)
    }
}

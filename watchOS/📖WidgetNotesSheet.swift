import SwiftUI

struct 📖WidgetNotesSheet: View {
    @EnvironmentObject var model: 📱AppModel
    private var ids: [UUID] { self.model.widgetState.info?.targetedNoteIDs ?? [] }
    var body: some View {
        NavigationStack {
            List {
                ForEach(self.ids, id: \.self) {
                    Self.NoteView(id: $0)
                }
                .onDelete {
                    guard let ⓘndex = $0.first else { return }
                    self.model.removeNote(self.ids[ⓘndex])
                }
            }
            .overlay {
                if self.model.deletedAllWidgetNotes { Self.DeletedNoteView() }
            }
        }
    }
}

private extension 📖WidgetNotesSheet {
    private struct NoteView: View {
        @EnvironmentObject var model: 📱AppModel
        var id: UUID
        private var ⓝoteIndex: Int? { self.model.notes.index(self.id) }
        private var singleNoteLayout: Bool { self.model.widgetState.info?.targetedNotesCount == 1 }
        var body: some View {
            if let ⓝoteIndex {
                NavigationLink {
                    📗NoteView(self.$model.notes[ⓝoteIndex], .notesSheet)
                } label: {
                    VStack(alignment: .leading) {
                        Text(self.model.notes[ⓝoteIndex].title)
                            .font(self.singleNoteLayout ? .title2 : .title3)
                            .bold()
                        Text(self.model.notes[ⓝoteIndex].comment)
                            .font(self.singleNoteLayout ? .body : .subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.vertical, self.singleNoteLayout ? 12 : 8)
            }
        }
    }
    private struct DeletedNoteView: View {
        var body: some View {
            VStack(spacing: 16) {
                Label("Deleted.", systemImage: "checkmark")
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                Image(systemName: "trash")
            }
            .foregroundColor(.primary)
            .imageScale(.small)
            .font(.title2)
            .padding(24)
        }
    }
}

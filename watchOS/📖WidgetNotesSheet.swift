import SwiftUI

struct 📖WidgetNotesSheet: View {
    @EnvironmentObject var 📱: 📱AppModel
    private var ⓘds: [UUID] { 📱.🪧widgetState.info?.targetedNoteIDs ?? [] }
    var body: some View {
        NavigationStack {
            List {
                ForEach(self.ⓘds, id: \.self) {
                    Self.🄽oteView(id: $0)
                }
                .onDelete {
                    guard let ⓘndex = $0.first else { return }
                    📱.removeNote(self.ⓘds[ⓘndex])
                }
            }
            .overlay {
                if 📱.deletedAllWidgetNotes { Self.🄳eletedNoteView() }
            }
        }
    }
}

private extension 📖WidgetNotesSheet {
    private struct 🄽oteView: View {
        @EnvironmentObject var 📱: 📱AppModel
        var id: UUID
        private var ⓝoteIndex: Int? { 📱.📚notes.index(self.id) }
        private var ⓞneNoteLayout: Bool { 📱.🪧widgetState.info?.targetedNotesCount == 1 }
        var body: some View {
            if let ⓝoteIndex {
                NavigationLink {
                    📗NoteView($📱.📚notes[ⓝoteIndex], .notesSheet)
                } label: {
                    VStack(alignment: .leading) {
                        Text(📱.📚notes[ⓝoteIndex].title)
                            .font(self.ⓞneNoteLayout ? .title2 : .title3)
                            .bold()
                        Text(📱.📚notes[ⓝoteIndex].comment)
                            .font(self.ⓞneNoteLayout ? .body : .subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.vertical, self.ⓞneNoteLayout ? 12 : 8)
            }
        }
    }
    private struct 🄳eletedNoteView: View {
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

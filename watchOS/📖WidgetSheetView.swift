import SwiftUI

struct 📖WidgetSheetView: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        NavigationStack {
            List {
                ForEach(self.model.openedWidgetNoteIDs, id: \.self) {
                    Self.NoteDetailLink(id: $0)
                }
                .onDelete { self.model.deleteNoteOnWidgetSheet($0) }
            }
            .overlay {
                if self.model.deletedAllWidgetNotes { Self.deletedNoteView() }
            }
        }
    }
}

private extension 📖WidgetSheetView {
    private struct NoteDetailLink: View {
        @EnvironmentObject var model: 📱AppModel
        var id: UUID
        private var ⓝoteIndex: Int? { self.model.notes.index(self.id) }
        private var singleNoteLayout: Bool { self.model.openedWidgetNotesCount == 1 }
        var body: some View {
            if let ⓝoteIndex {
                NavigationLink {
                    📗NoteView(self.$model.notes[ⓝoteIndex], .widgetSheet)
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
    private static func deletedNoteView() -> some View {
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

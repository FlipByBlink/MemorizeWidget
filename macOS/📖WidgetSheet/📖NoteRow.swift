import SwiftUI

struct 📖NoteRow: View {
    @EnvironmentObject var model: 📱AppModel
    private var id: UUID
    private var openedWidgetNoteIDsCache: [UUID]
    @State private var noteDeletion: Bool = false
    @State private var cachedNote: 📗Note?
    var body: some View {
        HStack(spacing: 16) {
            if self.noteDeletion {
                self.placeholderTexts()
            } else {
                if let ⓑindingNote = self.$model.notes.first(where: { $0.id == self.id }) {
                    VStack(spacing: 7) {
                        TextField("No title",
                                  text: ⓑindingNote.title,
                                  axis: .vertical)
                        .font(self.titleFont)
                        TextField("No comment",
                                  text: ⓑindingNote.comment,
                                  axis: .vertical)
                        .font(self.commentFont)
                    }
                    .textFieldStyle(.plain)
                    .fixedSize(horizontal: false, vertical: true)
                    .onSubmit { self.model.saveNotes() }
                } else {
                    Text(verbatim: "BUG")
                }
            }
            HStack(spacing: 12) {
                if self.noteDeletion {
                    self.placeholderButtons()
                } else {
                    if let ⓝote = self.model.notes.first(where: { $0.id == self.id }) {
                        🔍SearchButton([ⓝote])
                        📘DictionaryButton([ⓝote])
                        📖MoveEndButton(ⓝote)
                        self.removeButton()
                    } else {
                        Text(verbatim: "BUG")
                    }
                }
            }
            .labelStyle(.iconOnly)
        }
        .padding(.vertical, 12)
        .padding(.leading, 8)
        .padding(.trailing, 4)
    }
    init(_ id: UUID, _ openedWidgetNoteIDsCache: [UUID]) {
        self.id = id
        self.openedWidgetNoteIDsCache = openedWidgetNoteIDsCache
    }
}

private extension 📖NoteRow {
    private var titleFont: Font {
        .system(size: self.openedWidgetNoteIDsCache.count < 4 ? 24 : 17)
        .weight(.semibold)
    }
    private var commentFont: Font {
        .system(size: self.openedWidgetNoteIDsCache.count < 4 ? 15 : 13)
        .weight(.light)
    }
    private func removeButton() -> some View {
        Button {
            self.cachedNote = self.model.notes.first { $0.id == self.id }
            withAnimation { self.noteDeletion = true }
            Task {
                try? await Task.sleep(for: .seconds(0.4))
                self.model.removeNote(self.id)
            }
        } label: {
            Label("Delete", systemImage: "trash")
        }
    }
    private func placeholderTexts() -> some View {
        Group {
            if let cachedNote {
                VStack(spacing: 7) {
                    TextField("No title",
                              text: .constant(cachedNote.title),
                              axis: .vertical)
                    .font(self.titleFont)
                    TextField("No comment",
                              text: .constant(cachedNote.comment),
                              axis: .vertical)
                    .font(self.commentFont)
                }
                .textFieldStyle(.plain)
                .fixedSize(horizontal: false, vertical: true)
                .foregroundStyle(.tertiary)
                .disabled(true)
                .overlay {
                    Image(systemName: "trash")
                        .font(.title2.bold())
                        .foregroundColor(.secondary)
                        .padding(4)
                        .background(.background.opacity(0.8))
                }
            } else {
                Text(verbatim: "BUG")
            }
        }
    }
    private func placeholderButtons() -> some View {
        Group {
            Button {} label: { Image(systemName: "magnifyingglass") }
            Button {} label: { Image(systemName: "character.book.closed") }
            Button {} label: { Image(systemName: "arrow.down.to.line") }
            Button {} label: { Image(systemName: "trash") }
        }
        .disabled(true)
    }
}

//Workaround: Crash when using RemoveButton while editing textField
//Workaround: textFieldStyle(.plain) cause last-line-hidden

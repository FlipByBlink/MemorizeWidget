import SwiftUI

struct 📖MultiNotesLayoutView: View {
    @EnvironmentObject var model: 📱AppModel
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var body: some View {
        List {
            if self.targetNotesCount < 4 {
                ForEach(self.ids, id: \.self) { ⓘd in
                    Section { self.noteRow(ⓘd) }
                }
            } else {
                Section {
                    ForEach(self.ids, id: \.self) { self.noteRow($0) }
                }
            }
            if self.model.deletedAllWidgetNotes {
                Section { 📖DeletedNoteView() }
            }
        }
    }
}

private extension 📖MultiNotesLayoutView {
    private var ids: [UUID] {
        self.model.presentedSheetOnContentView?.widgetInfo?.targetedNoteIDs ?? []
    }
    private var targetNotesCount: Int {
        self.model.presentedSheetOnContentView?.widgetInfo?.targetedNotesCount ?? 0
    }
    private func noteRow(_ ⓘd: UUID) -> some View {
        Group {
            if let ⓘndex = self.model.notes.index(ⓘd) {
                if self.horizontalSizeClass == .compact {
                    VStack(spacing: 0) {
                        📗NoteView(self.$model.notes[ⓘndex],
                                   layout: .widgetSheet_multi(self.targetNotesCount))
                        HStack {
                            Spacer()
                            📖DictionaryButton(self.model.notes[ⓘndex])
                            Spacer()
                            🔍SearchButton(self.model.notes[ⓘndex])
                            Spacer()
                            if !self.model.randomMode {
                                📖MoveEndButton(self.model.notes[ⓘndex])
                                Spacer()
                            }
                            🚮DeleteNoteButton(self.model.notes[ⓘndex])
                            Spacer()
                        }
                        .labelStyle(.iconOnly)
                        .buttonStyle(.plain)
                        .foregroundColor(.primary)
                        .font(self.targetNotesCount < 4 ? .title3 : .body)
                        .padding(self.targetNotesCount < 4 ? 12 : 4)
                    }
                    .padding(self.targetNotesCount < 4 ? 8 : 4)
                } else {
                    HStack(spacing: 0) {
                        📗NoteView(self.$model.notes[ⓘndex],
                                   layout: .widgetSheet_multi(self.targetNotesCount))
                        HStack(spacing: 24) {
                            📖DictionaryButton(self.model.notes[ⓘndex])
                            🔍SearchButton(self.model.notes[ⓘndex])
                            if !self.model.randomMode { 📖MoveEndButton(self.model.notes[ⓘndex]) }
                            🚮DeleteNoteButton(self.model.notes[ⓘndex])
                        }
                        .labelStyle(.iconOnly)
                        .buttonStyle(.plain)
                        .foregroundColor(.primary)
                        .padding()
                        .font(self.targetNotesCount < 4 ? .title3 : .body)
                    }
                    .padding(self.targetNotesCount < 4 ? 8 : 0)
                }
            }
        }
    }
}

import SwiftUI

struct 📖MultiNotesLayoutView: View {
    @EnvironmentObject var model: 📱AppModel
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var body: some View {
        List {
            if self.lessThan4 {
                ForEach(self.model.openedWidgetNoteIDs, id: \.self) { ⓘd in
                    Section { self.noteRow(ⓘd) }
                }
            } else {
                Section {
                    ForEach(self.model.openedWidgetNoteIDs, id: \.self) {
                        self.noteRow($0)
                    }
                }
            }
            if self.model.deletedAllWidgetNotes {
                Section { 📖DeletedNoteView() }
            }
        }
    }
}

private extension 📖MultiNotesLayoutView {
    private var lessThan4: Bool { self.model.openedWidgetNotesCount < 4 }
    private func noteRow(_ ⓘd: UUID) -> some View {
        Group {
            if let ⓘndex = self.model.notes.index(ⓘd) {
                if self.horizontalSizeClass == .compact {
                    VStack(spacing: 0) {
                        📗NoteView(source: self.$model.notes[ⓘndex],
                                   titleFont: self.lessThan4 ? .title : .body,
                                   commentFont: self.lessThan4 ? .title3 : .subheadline,
                                   placement: .widgetSheet)
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
                        .font(self.lessThan4 ? .title3 : .body)
                        .padding(self.lessThan4 ? 12 : 4)
                    }
                    .padding(self.lessThan4 ? 8 : 4)
                } else {
                    HStack(spacing: 0) {
                        📗NoteView(source: self.$model.notes[ⓘndex],
                                   titleFont: self.lessThan4 ? .title : .body,
                                   commentFont: self.lessThan4 ? .title3 : .subheadline,
                                   placement: .widgetSheet)
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
                        .font(self.lessThan4 ? .title3 : .body)
                    }
                    .padding(self.lessThan4 ? 8 : 0)
                }
            }
        }
    }
}

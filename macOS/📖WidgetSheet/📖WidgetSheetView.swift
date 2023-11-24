import SwiftUI

struct 📖WidgetSheetView: View {
    @EnvironmentObject var model: 📱AppModel
    @State private var windowMinHeight: CGFloat?
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                if !self.model.deletedAllWidgetNotes {
                    ForEach(self.model.openedWidgetNoteIDs, id: \.self) {
                        if let ⓘndex = self.model.notes.index($0) {
                            📖NoteRow(source: self.$model.notes[ⓘndex])
                                .frame(minHeight: self.noteMinHeight)
                        }
                    }
                } else {
                    📖DeletedNoteView()
                }
            }
            .padding(.horizontal, 44)
            .frame(width: 640)
            .frame(minHeight: self.windowMinHeight)
            .toolbar {
                Button("Dismiss") { self.model.presentedSheetOnContentView = nil }
            }
        }
        .modifier(📣ADSheet())
        .animation(.default, value: self.model.presentedSheetOnContentView)
        .onAppear {
            self.windowMinHeight = self.noteMinHeight * .init(self.model.openedWidgetNoteIDs.count)
        }
    }
}

private extension 📖WidgetSheetView {
    private var noteMinHeight: CGFloat {
        if self.model.openedWidgetNotesCount < 4 {
            180
        } else {
            140
        }
    }
}

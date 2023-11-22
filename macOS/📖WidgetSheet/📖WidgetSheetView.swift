import SwiftUI

struct 📖WidgetSheetView: View { //MARK: WIP
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        NavigationStack {
            VStack {
                if !self.model.deletedAllWidgetNotes {
                    ForEach(self.model.openedWidgetNoteIDs, id: \.self) { ⓘd in
                        if let ⓘndex = self.model.notes.index(ⓘd) {
                            📖NoteRow(source: self.$model.notes[ⓘndex])
                        }
                    }
                } else {
                    📖DeletedNoteView()
                }
            }
            .padding(.horizontal, 44)
            .toolbar {
                Button("Dismiss") { self.model.presentedSheetOnContentView = nil }
            }
            //.modifier(📰SheetOnWidgetSheet.Handler())
        }
        .frame(width: 550,
               height: 180 * .init(self.model.openedWidgetNoteIDs.count))
    }
}

import SwiftUI

struct 📖WidgetSheetView: View {
    @EnvironmentObject var model: 📱AppModel
    @State private var windowHeight: CGFloat?
    var body: some View {
        NavigationStack {
            VStack {
                if !self.model.deletedAllWidgetNotes {
                    ForEach(self.model.openedWidgetNoteIDs, id: \.self) {
                        if let ⓘndex = self.model.notes.index($0) {
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
        }
        .modifier(📣ADSheet())
        .frame(width: 550, height: self.windowHeight)
        .onAppear {
            self.windowHeight = .init(180 * self.model.openedWidgetNoteIDs.count)
        }
    }
}

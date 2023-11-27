import SwiftUI

struct 📖WidgetSheetView: View {
    @EnvironmentObject var model: 📱AppModel
    @State private var openedWidgetNoteIDsCache: [UUID] = []
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ForEach(self.openedWidgetNoteIDsCache, id: \.self) {
                    📖NoteRow($0, self.openedWidgetNoteIDsCache)
                }
            }
            .padding(.vertical, 24)
            .padding(.horizontal, 44)
            .frame(width: 640)
            .toolbar { Button("Dismiss") { self.model.presentedSheetOnContentView = nil } }
        }
        .modifier(📣ADSheet())
        .animation(.default, value: self.model.presentedSheetOnContentView)
        .onAppear { self.openedWidgetNoteIDsCache = self.model.openedWidgetNoteIDs }
        .onDisappear { self.model.saveNotes() }
    }
}

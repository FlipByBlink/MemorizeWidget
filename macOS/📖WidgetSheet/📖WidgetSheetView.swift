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
            .padding(.vertical, 28)
            .padding(.horizontal, 40)
            .frame(width: 500)
            .toolbar { Button("Dismiss") { self.model.presentedSheetOnContentView = nil } }
        }
        .modifier(📣ADSheet())
        .animation(.default, value: self.model.presentedSheetOnContentView)
        .onAppear { self.openedWidgetNoteIDsCache = self.model.openedWidgetNoteIDs }
        .onChange(of: self.model.openedWidgetNoteIDs) {
            if !$0.isEmpty { self.openedWidgetNoteIDsCache = $0 }
        }
        .onDisappear { self.model.saveNotes() }
    }
}

import SwiftUI

struct 📚ContentView: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        NavigationStack {
            📚NotesList()
        }
        .onOpenURL(perform: self.model.handleWidgetURL)
        .modifier(🔦FocusedModelHandler())
        .modifier(📰SheetHandlerOnContentView())
        .modifier(🚮DeleteAllNotesButton.ConfirmDialog())
        .modifier(📣ADSheet())
        .modifier(💬RequestUserReview())
        .task { self.model.presentedSheetOnContentView = .notesImportText }
    }
}

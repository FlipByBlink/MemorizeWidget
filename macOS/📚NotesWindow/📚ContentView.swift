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
        .modifier(💬RequestUserReview())
        .task {
//            self.model.presentedSheetOnContentView =
//                .widget(.notes([self.model.notes[0].id,
//                                self.model.notes[1].id,
//                                self.model.notes[2].id]))
            self.model.presentedSheetOnContentView =
                .widget(.notes([self.model.notes.randomElement()!.id,
                                self.model.notes.randomElement()!.id,
                                self.model.notes.randomElement()!.id]))
//            self.model.presentedSheetOnContentView =
//                .widget(.notes([self.model.notes.randomElement()!.id]))
        }
    }
}

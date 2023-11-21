import SwiftUI

struct 📚ContentView: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        NavigationStack {
            📚NotesList()
                .navigationTitle("ノート")
        }
        .focusedValue(\.notesSelection, self.model.notesSelection)
        .focusedValue(\.notes, self.model.notes)
        .focusedValue(\.openedMainWindow, true)
        .focusedObject(self.model)
        .onOpenURL(perform: self.model.handleWidgetURL)
        .modifier(📰SheetHandlerOnContentView())
        .modifier(📣ADSheet())
        .modifier(💬RequestUserReview())
    }
}

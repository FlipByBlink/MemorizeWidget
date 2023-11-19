import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        NavigationStack {
            📚NotesListPanel()
        }
        .focusedValue(\.notesSelection, self.model.notesSelection)
        .focusedValue(\.notes, self.model.notes)
        .focusedObject(self.model)
        .onOpenURL(perform: self.model.handleWidgetURL)
        .modifier(📰SheetHandlerOnContentView())
        .modifier(📣ADSheet())
        .modifier(💬RequestUserReview())
        .frame(minWidth: 360, minHeight: 240)
    }
}

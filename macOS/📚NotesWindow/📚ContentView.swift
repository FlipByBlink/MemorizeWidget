import SwiftUI

struct 📚ContentView: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        NavigationStack {
            📚NotesList()
        }
        .modifier(🔦FocusedModelHandler())
        .modifier(📰SheetHandlerOnContentView())
        .modifier(🚮DeleteAllNotesButton.ConfirmDialog())
        .modifier(💬RequestUserReview())
    }
}

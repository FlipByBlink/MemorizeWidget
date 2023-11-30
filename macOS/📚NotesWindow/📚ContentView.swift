import SwiftUI

struct 📚ContentView: View {
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

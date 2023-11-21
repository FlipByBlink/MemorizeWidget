import SwiftUI

struct 📚ContentView: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        NavigationStack {
            📚NotesList()
                .navigationTitle("ノート")
        }
        .onOpenURL(perform: self.model.handleWidgetURL)
        .modifier(🔦FocusedModel())
        .modifier(📰SheetHandlerOnContentView())
        .modifier(📣ADSheet())
        .modifier(💬RequestUserReview())
    }
}

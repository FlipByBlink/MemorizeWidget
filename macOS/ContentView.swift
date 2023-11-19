import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        NavigationStack {
            📚NotesListPanel()
        }
        .focusedObject(self.model)
        .modifier(📣ADSheet())
        .modifier(💬RequestUserReview())
        .frame(minWidth: 360, minHeight: 240)
    }
}

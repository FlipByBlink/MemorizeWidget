import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        NavigationStack {
            📚NotesListPanel()
        }
        .focusedObject(self.model)
        .frame(minWidth: 360, minHeight: 300)
    }
}

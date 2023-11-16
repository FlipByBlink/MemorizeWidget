import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        NavigationStack {
            List {
                NavigationLink {
                    📚NotesListMenu()
                } label: {
                    LabeledContent {
                        Text(verbatim: "\(self.model.notes.count)")
                    } label: {
                        Label("Notes", systemImage: "books.vertical")
                    }
                }
                NavigationLink {
                    🔩MainMenu()
                } label: {
                    Label("Menu", systemImage: "gearshape")
                }
                NavigationLink {
                    💁GuideMenu()
                } label: {
                    Label("Guide", systemImage: "star.bubble")
                }
                NavigationLink {
                    ℹ️AboutAppMenu()
                } label: {
                    Label("About App", systemImage: "questionmark")
                }
            }
            .navigationTitle("MemorizeWidget")
        }
        .onOpenURL(perform: self.model.handleWidgetURL)
        .modifier(📰SheetHandlerOnContentView())
    }
}

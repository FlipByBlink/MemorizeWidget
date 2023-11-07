import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        NavigationStack {
            List {
                NavigationLink {
                    📚NotesMenu()
                } label: {
                    LabeledContent {
                        Text("\(self.model.notes.count)")
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
                    💁TipsMenu()
                } label: {
                    Label("Tips", systemImage: "star.bubble")
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
        .modifier(📰SheetOnContentView.Handler())
    }
}

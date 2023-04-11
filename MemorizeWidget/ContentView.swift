import SwiftUI

struct ContentView: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        self.ⓣabView()
            .onOpenURL(perform: 📱.handleWidgetURL)
            .modifier(📖WidgetNotesSheet())
            .modifier(📥NotesImportSheet())
            .modifier(💬RequestUserReview())
            .modifier(🩹Workaround.hideTitleBarOnMacCatalyst())
    }
    private func ⓣabView() -> some View {
        TabView(selection: $📱.🔖tab) {
            📚NotesListTab()
                .tag(🔖Tab.notesList)
                .tabItem { Label("Notes", systemImage: "text.justify.leading") }
            🔩MenuTab()
                .tag(🔖Tab.menu)
                .tabItem { Label("Menu", systemImage: "gearshape") }
            🗑TrashTab()
                .tag(🔖Tab.trash)
                .tabItem { Label("Trash", systemImage: "trash") }
            💁GuideTab()
                .tag(🔖Tab.guide)
                .badge(📱.exceedDataSizePerhaps ? "!" : nil)
                .tabItem { Label("Guide", systemImage: "questionmark") }
            ℹ️AboutAppTab()
                .tag(🔖Tab.app)
                .tabItem { Label("App", systemImage: "info") }
        }
    }
}

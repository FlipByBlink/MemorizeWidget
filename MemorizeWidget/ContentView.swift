import SwiftUI

struct ContentView: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        self.ⓣabView()
            .onOpenURL(perform: 📱.handleWidgetURL)
            .sheet(isPresented: $📱.🪧widgetState.showSheet) { 📖WidgetNotesSheet() }
            .sheet(isPresented: $📱.🚩showNotesImportSheet) { 📥NotesImportSheet() }
            .modifier(💾HandleShareExtensionData())
            .modifier(💬RequestUserReview())
    }
    private func ⓣabView() -> some View {
        TabView(selection: $📱.🔖tab) {
            📚NotesListTab()
                .tag(🔖Tab.notesList)
                .tabItem { Label("Notes", systemImage: "text.justify.leading") }
            🔩MenuTab()
                .tag(🔖Tab.menu)
                .tabItem { Label("Menu", systemImage: "gearshape") }
            💁GuideTab()
                .tag(🔖Tab.guide)
                .badge(📱.exceedDataSizePerhaps ? "!" : nil)
                .tabItem { Label("Guide", systemImage: "questionmark") }
            ℹ️AboutAppTab()
                .tag(🔖Tab.app)
                .tabItem { Label("App", systemImage: "app.badge") }
        }
    }
}

enum 🔖Tab {
    case notesList, menu, guide, app
}

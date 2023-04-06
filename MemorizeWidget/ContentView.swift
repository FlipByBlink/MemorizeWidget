import SwiftUI

struct ContentView: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        self.ⓣabView()
            .onOpenURL(perform: 📱.handleWidgetURL)
            .sheet(isPresented: $📱.🪧widgetState.showSheet) { 📖WidgetNotesSheet() }
            .sheet(isPresented: $📱.🚩showNotesImportSheet) { 📥NotesImportSheet() }
            .modifier(💾HandleShareExtensionData())
            .modifier(🚥HandleScenePhase())
            .modifier(💬RequestUserReview())
            .modifier(🚨SizeLimitAlert())
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
                .tabItem { Label("Guide", systemImage: "questionmark") }
            ℹ️AboutAppTab()
                .tag(🔖Tab.about)
                .tabItem { Label("About App", systemImage: "app.badge") }
        }
    }
}

enum 🔖Tab {
    case notesList, menu, guide, about
}

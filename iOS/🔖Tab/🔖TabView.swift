import SwiftUI

struct 🔖TabView: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        TabView(selection: self.$model.selectedTab) {
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
                .badge(self.model.exceedDataSizePerhaps ? "!" : nil)
                .tabItem { Label("Guide", systemImage: "questionmark") }
            ℹ️AboutAppTab()
                .tag(🔖Tab.app)
                .tabItem { Label("App", systemImage: "info") }
        }
    }
}

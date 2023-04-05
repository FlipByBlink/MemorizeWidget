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
            .modifier(🗑HandleTrashBox())
    }
    private func ⓣabView() -> some View {
        TabView(selection: $📱.🔖tab) {
            📚NotesListTab()
                .tag(🔖Tab.notesList)
                .tabItem { Label("Notes", systemImage: "text.justify.leading") }
            🔩OptionTab()
                .tag(🔖Tab.option)
                .tabItem { Label("Option", systemImage: "gearshape") }
            🛒PurchaseTab()
                .tag(🔖Tab.purchase)
                .tabItem { Label("Purchase", systemImage: "cart") }
            ℹ️AboutAppTab()
                .tag(🔖Tab.about)
                .tabItem { Label("About App", systemImage: "questionmark") }
        }
    }
}

enum 🔖Tab {
    case notesList, option, purchase, about
}

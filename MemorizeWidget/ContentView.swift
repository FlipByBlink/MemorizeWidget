import SwiftUI
import WidgetKit

struct ContentView: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
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
        .onOpenURL { 📱.handleWidgetURL($0) }
        .sheet(isPresented: $📱.🚩showNoteSheet) { 📖NoteSheet() }
        .sheet(isPresented: $📱.🚩showNotesImportSheet) { 📥NotesImportSheet() }
    }
}

enum 🔖Tab {
    case notesList, option, purchase, about
}

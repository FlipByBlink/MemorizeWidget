import SwiftUI
import WidgetKit

struct ContentView: View {
    @EnvironmentObject var 📱: 📱AppModel
    @State private var 🔖tab: 🔖Tab = .notesList
    var body: some View {
        TabView(selection: self.$🔖tab) {
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
        .onOpenURL { 🔗 in
            📱.🚩showNotesImportSheet = false
            📱.🚩showNoteSheet = false
            if 🔗.description == "NewNoteShortcut" {
                📱.addNewNote()
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            } else if 📱.📚notes.contains(where: { $0.id.description == 🔗.description }) {
                📱.🚩showNoteSheet = true
                📱.🆔openedNoteID = 🔗.description
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            }
            self.🔖tab = .notesList
        }
        .sheet(isPresented: $📱.🚩showNoteSheet) {
            📖NoteSheet()
        }
        .sheet(isPresented: $📱.🚩showNotesImportSheet) {
            📥NotesImportSheet()
        }
        .modifier(💾OperateData())
    }
    enum 🔖Tab {
        case notesList, option, purchase, about
    }
}

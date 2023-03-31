import SwiftUI

class 📱AppModel: ObservableObject {
    @Published var 📚notes: 📚Notes = .load() ?? .sample
    
    @Published var 🔖tab: 🔖Tab = .notesList
    
    @Published var 🚩showNoteSheet: Bool = false
    @Published var 🆔openedNoteID: String? = nil
    
    @Published var 🚩showNotesImportSheet: Bool = false
    
    func addNewNote(_ ⓘndex: Int = 0) {
        withAnimation {
            self.📚notes.insert(📗Note(""), at: ⓘndex)
        }
        UISelectionFeedbackGenerator().selectionChanged()
    }
    
    func handleWidgetURL(_ ⓤrl: URL) {
        Task { @MainActor in
            self.🚩showNotesImportSheet = false
            self.🚩showNoteSheet = false
            if ⓤrl.description == "NewNoteShortcut" {
                self.addNewNote()
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            } else if self.📚notes.contains(where: { $0.id.description == ⓤrl.description }) {
                self.🚩showNoteSheet = true
                self.🆔openedNoteID = ⓤrl.description
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            }
            self.🔖tab = .notesList
        }
    }
    
    init() {
        self.📚notes.cleanEmptyTitleNotes()
    }
}

import SwiftUI

class 📱AppModel: ObservableObject {
    @Published var 📚notes: 📚Notes = .load() ?? .sample
    
    @Published var 🔖tab: 🔖Tab = .notesList
    
    @Published var 🚩showNoteSheet: Bool = false
    @Published var 🆔openedNoteID: UUID? = nil
    
    @Published var 🚩showNotesImportSheet: Bool = false
    
    @AppStorage("RandomMode", store: .ⓐppGroup) var 🚩randomMode: Bool = false
    
    init() {
        self.📚notes.cleanEmptyTitleNotes()
    }
}

//MARK: ComputedProperty, Method
extension 📱AppModel {
    var ⓞpenedNote: 📗Note? {
        guard let 🆔openedNoteID else { return nil }
        return self.📚notes.first { $0.id == 🆔openedNoteID }
    }
    
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
                self.🆔openedNoteID = UUID(uuidString: ⓤrl.description)
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            }
            self.🔖tab = .notesList
        }
    }
}

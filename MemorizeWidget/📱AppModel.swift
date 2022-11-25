
import SwiftUI

class 📱AppModel: ObservableObject {
    @Published var 📚notes: [📗Note]
    
    @Published var 🚩showNoteSheet: Bool = false
    @Published var 🆔openedNoteID: String? = nil
    
    @Published var 🚩showNotesImportSheet: Bool = false
    
    @Published var 🆕newNoteID: UUID? = nil
    
    func addNewNote(_ ⓘndex: Int = 0) {
        let ⓝewNote = 📗Note("")
        📚notes.insert(ⓝewNote, at: ⓘndex)
        UISelectionFeedbackGenerator().selectionChanged()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
            self.🆕newNoteID = ⓝewNote.id
        }
    }
    
    func saveNotes() {
        💾DataManager.save(📚notes)
    }
    
    func loadNotes() {
        📚notes = 💾DataManager.notes
    }
    
    init() {
        💾DataManager.cleanEmptyTitleNotes()
        📚notes = 💾DataManager.notes
    }
}

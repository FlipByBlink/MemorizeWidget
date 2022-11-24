
import SwiftUI
import WidgetKit

class 📱AppModel: ObservableObject {
    @Published var 📚notes: [📗Note]
    
    @Published var 🚩showNoteSheet: Bool = false
    @Published var 🆔openedNoteID: String? = nil
    
    @Published var 🚩showNotesImportSheet: Bool = false
    
    func addNewNote(_ ⓘndex: Int = 0) {
        📚notes.insert(📗Note(""), at: ⓘndex)
        UISelectionFeedbackGenerator().selectionChanged()
    }
    
    func saveNotes() {
        💾DataManager.save(📚notes)
    }
    
    func loadNotes() {
        guard let ⓝotes = 💾DataManager.notes else { return }
        📚notes = ⓝotes
    }
    
    init() {
        💾DataManager.cleanEmptyTitleNotes()
        📚notes = 💾DataManager.notes ?? 📚SampleNotes
    }
}




let 📚SampleNotes: [📗Note] = 🄲onvertTextToNotes("""
Lemon,yellow sour
Strawberry,jam red sweet
Grape,seedless wine white black
""", .comma)//TODO: 再検討

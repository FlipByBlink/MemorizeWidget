import SwiftUI

extension 📱AppModel {
    func submitTextField(_ ⓢource: 📗Note) {
        self.saveNotes()
        self.notesSelection = [ⓢource.id]
    }
    func clearSelection() {
        self.notesSelection.removeAll()
    }
    func removeSelectedNote() {
        self.notes.removeAll { self.notesSelection.contains($0.id) }
        self.saveNotes()
        self.clearSelection()
    }
    func insertNewNoteOnTop() {
        self.clearSelection()
        self.addNewNoteOnTop()
    }
    func insertAbove() {
        if let ⓘndex = self.notes.firstIndex(where: { $0.id == self.notesSelection.first }) {
            self.clearSelection()
            self.addNewNote(index: ⓘndex)
        }
    }
    func insertBelow() {
        if let ⓘndex = self.notes.firstIndex(where: { $0.id == self.notesSelection.first }) {
            self.clearSelection()
            self.addNewNote(index: ⓘndex + 1)
        }
    }
}

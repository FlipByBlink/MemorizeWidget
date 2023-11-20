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
    //func targetNotesForCommands(_ ⓔditingNote: 📗Note?) -> Set<📗Note> {
    //
    //}
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

//enum ActionKind {
//    case commandForSelectedNote
//    case commandForEditingNote(📗Note)
//    case onDeleteInForEach(IndexSet)
//    case onMoveInForEach(IndexSet, Int)
//    case contextMenu(Set<UUID>)
//    case trailingButton(📗Note)
//    case newNoteOnTopButton
//}

//enum ActionKind {
//    case delete
//    case move
//    case insert
//}

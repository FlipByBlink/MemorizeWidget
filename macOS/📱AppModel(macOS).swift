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
    func insertAbove(_ ⓣargetNotes: Set<📗Note>) {
        if let ⓝote = ⓣargetNotes.first,
           let ⓘndex = self.notes.firstIndex(of: ⓝote) {
            self.clearSelection()
            self.addNewNote(index: ⓘndex)
        }
    }
    func insertBelow(_ ⓣargetNotes: Set<📗Note>) {
        if let ⓝote = ⓣargetNotes.first,
           let ⓘndex = self.notes.firstIndex(of: ⓝote) {
            self.clearSelection()
            self.addNewNote(index: ⓘndex + 1)
        }
    }
    func moveTop(_ ⓝotes: Set<📗Note>) {
        self.notes.move(fromOffsets: .init(ⓝotes.compactMap({ self.notes.firstIndex(of: $0)})),
                        toOffset: 0)
        self.saveNotes()
    }
    func moveEnd(_ ⓝotes: Set<📗Note>) {
        self.notes.move(fromOffsets: .init(ⓝotes.compactMap({ self.notes.firstIndex(of: $0)})),
                        toOffset: self.notes.endIndex)
        self.saveNotes()
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

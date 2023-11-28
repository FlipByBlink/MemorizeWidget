import SwiftUI

extension 📱AppModel {
    func clearSelection() {
        self.notesSelection.removeAll()
    }
    func removeNotesByDeleteCommand() {
        let ⓣargetNotes = self.notes.filter { self.notesSelection.contains($0.id) }
        self.trash.storeDeletedNotes(ⓣargetNotes)
        self.notes.removeAll { ⓣargetNotes.contains($0) }
        self.saveNotes()
        self.clearSelection()
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
        self.notes.move(fromOffsets: .init(ⓝotes.compactMap { self.notes.firstIndex(of: $0) }),
                        toOffset: 0)
        self.saveNotes()
        self.clearSelection()
    }
    func moveEnd(_ ⓝotes: Set<📗Note>) {
        self.notes.move(fromOffsets: .init(ⓝotes.compactMap { self.notes.firstIndex(of: $0) }),
                        toOffset: self.notes.endIndex)
        self.saveNotes()
        self.clearSelection()
    }
}

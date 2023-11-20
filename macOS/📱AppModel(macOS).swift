import SwiftUI

extension 📱AppModel {
    func clearSelection() {
        self.notesSelection.removeAll()
    }
    func removeSelectedNote() {
        self.notes.removeAll { self.notesSelection.contains($0.id) }
        self.clearSelection()
    }
    func insertAbove() {
        if let ⓘndex = self.notes.firstIndex(where: { $0.id == self.notesSelection.first }) {
            self.insertNewNote(ⓘndex)
        }
    }
    func insertBelow() {
        if let ⓘndex = self.notes.firstIndex(where: { $0.id == self.notesSelection.first }) {
            self.insertNewNote(ⓘndex + 1)
        }
    }
}

private extension 📱AppModel {
    private func insertNewNote(_ ⓘndex: Int) {
        let ⓝewNote: 📗Note = .empty
        self.notes.insert(ⓝewNote, at: ⓘndex)
        self.notesSelection.removeAll()
        Task {
            try? await Task.sleep(for: .seconds(0.4))
            self.createdNewNoteID = ⓝewNote.id
        }
    }
}

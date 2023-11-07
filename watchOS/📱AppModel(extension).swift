import SwiftUI

extension 📱AppModel {
    func deleteNoteOnWidgetSheet(_ ⓘndexSet: IndexSet) {
        guard let ⓘndex = ⓘndexSet.first else { return }
        self.removeNote(self.openedWidgetNoteIDs[ⓘndex])
    }
    func addNewNoteOnShortcutSheet(_ ⓝote: 📗Note) {
        self.insertOnTop([ⓝote])
        self.presentedSheetOnContentView = nil
        💥Feedback.success()
    }
}

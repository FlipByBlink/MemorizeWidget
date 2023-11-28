import SwiftUI

extension 📱AppModel {
    func deleteNoteOnWidgetSheet(_ ⓘndexSet: IndexSet) {
        if let ⓘndex = ⓘndexSet.first {
            self.removeNote(self.openedWidgetNoteIDs[ⓘndex])
        }
    }
    func addNewNoteOnShortcutSheet(_ ⓝote: 📗Note) {
        self.insertOnTop([ⓝote])
        self.presentedSheetOnContentView = nil
        💥Feedback.success()
    }
}

import SwiftUI

extension 📱AppModel {
    func deleteNoteOnWidgetSheet(_ ⓘndexSet: IndexSet) {
        guard let ⓘndex = ⓘndexSet.first else { return }
        self.removeNote(self.openedWidgetNoteIDs[ⓘndex])
    }
}

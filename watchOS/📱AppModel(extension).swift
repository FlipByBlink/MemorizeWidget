import SwiftUI

extension 📱AppModel {
//    func handleNewNoteShortcut(_ ⓤrl: URL) { //TODO: 実装
//        
//    }
    func deleteNoteOnWidgetSheet(_ ⓘndexSet: IndexSet) {
        guard let ⓘndex = ⓘndexSet.first else { return }
        self.removeNote(self.openedWidgetNoteIDs[ⓘndex])
    }
}

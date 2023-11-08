import SwiftUI

extension 📱AppModel {
    func handleNewNoteShortcut(_ ⓤrl: URL, _ ⓢcrollViewProxy: ScrollViewProxy) {
        if case .newNoteShortcut = 🪧WidgetInfo.load(ⓤrl) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                ⓢcrollViewProxy.scrollTo("NewNoteButton")
                self.addNewNoteOnTop()
            }
        }
    }
    func exceedDataSize(_ ⓒonvertingText: String) -> Bool {
        let ⓒonvertingNotes = 📚TextConvert.decode(ⓒonvertingText, self.separator)
        return (ⓒonvertingNotes.dataCount + self.notes.dataCount) > 800000
    }
}

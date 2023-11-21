import SwiftUI

extension 📱AppModel {
    func apply(_ ⓘnputtedNote: 📗Note, target ⓣargetNote: 📗Note) {
        guard let ⓘndex = self.notes.firstIndex(of: ⓣargetNote) else { return }
        self.notes[ⓘndex].title = ⓘnputtedNote.title
        self.notes[ⓘndex].comment = ⓘnputtedNote.comment
        self.saveNotes()
    }
    func addNewNoteBelow(_ ⓝote: 📗Note) {
        guard let ⓘndex = self.notes.firstIndex(of: ⓝote) else { return }
        self.addNewNote(index: ⓘndex + 1)
    }
    func switchNotesListTab() {
        self.selectedTab = .notesList
        self.selectedSidebar = .notesList
    }
    func scrollTopByNewNoteShortcut(_ ⓤrl: URL, _ ⓢcrollViewProxy: ScrollViewProxy) {
        if case .newNoteShortcut = 🪧Tag.decode(ⓤrl) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                ⓢcrollViewProxy.scrollTo("NewNoteButton")
            }
        }
    }
    func addNewNoteByNewNoteShortcut() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.addNewNoteOnTop()
        }
    }
    func handleToPresentADSheet() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            if self.inAppPurchaseModel.checkToShowADSheet() {
                self.presentedSheetOnWidgetSheet = .ad
            }
        }
    }
    func dismissWidgetSheetOnBackground(_ ⓢcenePhase: ScenePhase) {
        guard case .widget(_) = self.presentedSheetOnContentView else {
            return
        }
        if ⓢcenePhase == .background {
            self.presentedSheetOnWidgetSheet = nil
            self.presentedSheetOnContentView = nil
        }
    }
}

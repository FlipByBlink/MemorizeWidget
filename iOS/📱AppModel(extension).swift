import SwiftUI

extension 📱AppModel {
//    func switchLayout(_ ⓗorizontalSizeClass: UserInterfaceSizeClass?) { //TODO: 要再検討
//        switch ⓗorizontalSizeClass {
//            case .compact:
//                self.selectedTab = self.selectedSidebar ?? .notesList
//            case .regular:
//                self.selectedSidebar = self.selectedTab
//            default:
//                break
//        }
//    }
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
    func submitNotesImport(_ ⓒonvertedNotes: 📚Notes) {
        self.insertOnTop(ⓒonvertedNotes)
        self.presentedSheetOnContentView = nil
        💥Feedback.success()
    }
}

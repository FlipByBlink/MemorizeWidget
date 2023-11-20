import SwiftUI

extension 📱AppModel: NSApplicationDelegate {
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        false
    }
    func applicationDidResignActive(_ notification: Notification) {
        self.saveNotes()
    }
    func application(_ application: NSApplication, open urls: [URL]) {
        //guard let ⓤrl = urls.first else { return }
        //guard !self.showADSheet else { return }
        //guard let ⓣarget = 📝NoteFamily.decode(ⓤrl) else {
        //    assertionFailure("Failed url decode")
        //    return
        //}
        //self.target = ⓣarget
        //self.showNoteWindow()
        //if self.inAppPurchaseModel.checkToShowADSheet() { self.showADSheet = true }
    }
}

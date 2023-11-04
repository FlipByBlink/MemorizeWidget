import SwiftUI

enum 🩹Workaround {
    struct CloseMenePopup: ViewModifier {
        @Environment(\.scenePhase) var scenePhase
        func body(content: Content) -> some View {
            content
                .onChange(of: self.scenePhase) { [scenePhase] ⓝewValue in
                    if scenePhase == .active, ⓝewValue == .inactive {
                        self.closeMenuPopup()
                    }
                }
        }
        private func closeMenuPopup() {
            let ⓦindowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            ⓦindowScene?.windows.first?.rootViewController?.dismiss(animated: true)
        }
        //Conflict error Menu-popup / sheetPresentation
        //> [Presentation]
        //> Attempt to present <_> on <_> (from <_>)
        //> which is already presenting <_UIContextMenuActionsOnlyViewController: _>.
    }
    struct HideTitleBarOnMacCatalyst: ViewModifier {
        func body(content: Content) -> some View {
            content
                .onAppear {
#if targetEnvironment(macCatalyst)
                    (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.titlebar?.titleVisibility = .hidden
#endif
                }
        }
    }
}

//MARK: Draft
//Button {
//} label: { Label("Move top", systemImage: "arrow.up.to.line") }
//Button {
//} label: { Label("Move end", systemImage: "arrow.down.to.line") }

//MARK: REJECT .defaultAppStorage(UserDefaults(suiteName: `AppGroupID`)!)
//reason: buggy list-animation on iOS15.x

//MARK: Size limitation
//[User Defaults] CFPrefsPlistSource<0x2838db480> (Domain: group.net.aaaakkkkssssttttnnnn.MemorizeWidget, User: kCFPreferencesCurrentUser, ByHost: No, Container: (null), Contents Need Refresh: No): Attempting to store >= 4194304 bytes of data in CFPreferences/NSUserDefaults on this platform is invalid. This is a bug in MemorizeWidget or a library it uses.
//    Description of keys being set:
//Notes: data value, size: 4521029
//
//    Description of keys already present:
//Notes: data value, size: 4173442
//TrashBox: data value, size: 498
//DeletedContents: data value, size: 309
//savedDataByShareExtension: boolean value
//savedByExtension: boolean value

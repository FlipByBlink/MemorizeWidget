import SwiftUI

enum 🩹Workaround {
    struct CloseMenePopup: ViewModifier {
        @EnvironmentObject var model: 📱AppModel
        @Environment(\.scenePhase) var scenePhase
        func body(content: Content) -> some View {
            content
                .onChange(of: self.scenePhase) { [scenePhase] ⓝewValue in
                    guard self.notPresentedSheet else { return }
                    if scenePhase == .active, ⓝewValue == .inactive {
                        self.closeMenuPopup()
                    }
                }
        }
        private func closeMenuPopup() {
            let ⓦindowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            ⓦindowScene?.windows.first?.rootViewController?.dismiss(animated: true)
        }
        private var notPresentedSheet: Bool {
            self.model.presentedSheetOnContentView == nil
            //Prevent to dismiss sheet because of inAppPurchase dialog
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

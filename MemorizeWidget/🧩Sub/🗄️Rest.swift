import SwiftUI

struct 🚥HandleScenePhase: ViewModifier {
    @EnvironmentObject var 📱: 📱AppModel
    @Environment(\.scenePhase) var scenePhase
    func body(content: Content) -> some View {
        content
            .onChange(of: self.scenePhase) { [scenePhase] ⓝewValue in
                📱.handleLeavingApp(scenePhase, ⓝewValue)
            }
    }
}

struct 💾HandleShareExtensionData: ViewModifier {
    @EnvironmentObject var 📱: 📱AppModel
    @AppStorage("savedByExtension", store: .ⓐppGroup) private var 🚩savedByExtension: Bool = false
    func body(content: Content) -> some View {
        content
            .onAppear { self.🚩savedByExtension = false }
            .onChange(of: self.🚩savedByExtension) {
                if $0 == true {
                    📱.reloadNotes()
                    self.🚩savedByExtension = false
                }
            }
    }
}

struct 💬RequestUserReview: ViewModifier {
    @EnvironmentObject var 📱: 📱AppModel
    @State private var ⓒheckToRequest: Bool = false
    func body(content: Content) -> some View {
        content
            .modifier(💬PrepareToRequestUserReview(self.$ⓒheckToRequest))
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 120) {
                    self.ⓒheckToRequest = true
                }
            }
    }
}

enum 🩹Workaround {
    struct closeMenePopup: ViewModifier {
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
}

//MARK: Draft
//Button {
//} label: { Label("Move top", systemImage: "arrow.up.to.line") }
//Button {
//} label: { Label("Move end", systemImage: "arrow.down.to.line") }

//MARK: REJECT .defaultAppStorage(UserDefaults(suiteName: `AppGroupID`)!)
//reason: buggy list-animation on iOS15.x

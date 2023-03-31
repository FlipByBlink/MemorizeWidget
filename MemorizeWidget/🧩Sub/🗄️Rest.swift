import SwiftUI

struct 🛒PurchaseTab: View {
    @EnvironmentObject var 🛒: 🛒StoreModel
    var body: some View {
        NavigationView { 📣ADMenu() }
            .navigationViewStyle(.stack)
    }
}

struct 💾HandleShareExtensionData: ViewModifier {
    @EnvironmentObject var 📱: 📱AppModel
    @AppStorage("savedByExtension", store: .ⓐppGroup) private var 🚩savedByExtension: Bool = false
    func body(content: Content) -> some View {
        content
            .onAppear {
                self.🚩savedByExtension = false
            }
            .onChange(of: self.🚩savedByExtension) {
                if $0 == true {
                    guard let ⓝotes = 📚Notes.load() else { return }
                    📱.📚notes = ⓝotes
                    self.🚩savedByExtension = false
                }
            }
    }
}

enum 🩹Workaround {
    static func closeMenuPopup() {
        //Conflict error Menu-popup / sheetPresentation
        //> [Presentation]
        //> Attempt to present <_> on <_> (from <_>)
        //> which is already presenting <_UIContextMenuActionsOnlyViewController: _>.
        let ⓦindowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        ⓦindowScene?.windows.first?.rootViewController?.dismiss(animated: true)
    }
}

//MARK: REJECT .defaultAppStorage(UserDefaults(suiteName: `AppGroupID`)!)
//reason: buggy list-animation on iOS15.x

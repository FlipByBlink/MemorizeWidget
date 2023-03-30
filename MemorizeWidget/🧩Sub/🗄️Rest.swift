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
    @AppStorage("savedDataByShareExtension", store: 💾AppGroupDefaults) private var 🚩savedDataByShareExtension: Bool = false
    func body(content: Content) -> some View {
        content
            .onAppear {
                self.🚩savedDataByShareExtension = false
            }
            .onChange(of: self.🚩savedDataByShareExtension) {
                if $0 == true {
                    guard let ⓝotes = 📚Notes.load() else { return }
                    📱.📚notes = ⓝotes
                    self.🚩savedDataByShareExtension = false
                }
            }
    }
}

//MARK: - REJECT .defaultAppStorage(UserDefaults(suiteName: `AppGroupID`)!)
//reason: buggy list-animation on iOS15.x

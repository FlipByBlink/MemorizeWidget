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

//MARK: - REJECT .defaultAppStorage(UserDefaults(suiteName: `AppGroupID`)!)
//reason: buggy list-animation on iOS15.x

import SwiftUI

struct 🛒PurchaseTab: View {
    @EnvironmentObject var 🛒: 🛒StoreModel
    var body: some View {
        NavigationView { 📣ADMenu() }
            .navigationViewStyle(.stack)
    }
}

struct 💾OperateData: ViewModifier {
    @EnvironmentObject var 📱: 📱AppModel
    @AppStorage("savedDataByShareExtension", store: 💾AppGroupUD) private var 🚩savedDataByShareExtension: Bool = false
    func body(content: Content) -> some View {
        content
            .onChange(of: 📱.📚notes) { _ in
                📱.saveNotes()
            }
            .onAppear {
                self.🚩savedDataByShareExtension = false
            }
            .onChange(of: self.🚩savedDataByShareExtension) {
                if $0 == true {
                    📱.loadNotes()
                    self.🚩savedDataByShareExtension = false
                }
            }
    }
}

//MARK: - REJECT .defaultAppStorage(UserDefaults(suiteName: `AppGroupID`)!)
//reason: buggy list-animation on iOS15.x

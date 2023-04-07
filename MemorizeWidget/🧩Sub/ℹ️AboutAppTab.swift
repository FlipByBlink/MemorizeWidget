import SwiftUI

struct ℹ️AboutAppTab: View {
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack { self.ⓛistView() }
        } else {
            NavigationView { self.ⓛistView() }
                .navigationViewStyle(.stack)
        }
    }
    private func ⓛistView() -> some View {
        List {
            ℹ️AboutAppLink(name: "MemorizeWidget", subtitle: "App for iPhone / iPad / Apple Watch")
            📣ADMenuLink()
        }
        .navigationTitle("App")
    }
}

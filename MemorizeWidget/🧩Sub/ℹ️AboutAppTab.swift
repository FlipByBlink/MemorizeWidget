import SwiftUI

struct ℹ️AboutAppTab: View {
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack { self.ⓒontent() }
        } else {
            NavigationView { self.ⓒontent() }
                .navigationViewStyle(.stack)
        }
    }
    private func ⓒontent() -> some View {
        List {
            ℹ️AboutAppLink(name: "MemorizeWidget",
                           subtitle: "App for iPhone / iPad / Apple Watch / Mac")
            📣ADMenuLink()
        }
        .navigationTitle("App")
    }
}

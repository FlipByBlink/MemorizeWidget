import SwiftUI

struct 🔍SearchSheetView: View {
    var url: URL
    var body: some View {
        🔍UIKitSafariView(url: self.url)
            .ignoresSafeArea()
            .presentationDetents([.height(640)])
    }
    init(_ url: URL) {
        self.url = url
    }
}

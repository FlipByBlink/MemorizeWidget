import SwiftUI

struct 🔍SearchSheetView: View {
    var url: URL
    var body: some View {
        🔍BrowserView(url: self.url)
            .ignoresSafeArea()
            .presentationDetents([.medium])
    }
    init(_ url: URL) {
        self.url = url
    }
}

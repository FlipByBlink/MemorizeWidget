import SwiftUI

struct 🔍CustomizeSearchSheetView: View {
    var body: some View {
        NavigationStack {
            🔍CustomizeSearchMenu()
                .toolbar { 📰DismissButton() }
        }
    }
}

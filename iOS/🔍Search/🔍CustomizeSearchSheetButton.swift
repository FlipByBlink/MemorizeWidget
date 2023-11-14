import SwiftUI

struct 🔍CustomizeSearchSheetButton: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        Button {
            self.model.presentSheet(.customizeSearch)
        } label: {
            Label("Customize search function", systemImage: "magnifyingglass")
        }
    }
}

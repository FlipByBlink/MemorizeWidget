import SwiftUI

struct 🏢IPadView: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        NavigationSplitView {
            🔖SidebarView()
        } detail: {
            if let ⓢelectedSidebar = self.model.selectedSidebar {
                ⓢelectedSidebar.detailView
            } else {
                Self.placeholderView()
            }
        }
        .navigationSplitViewStyle(.balanced)
    }
}

private extension 🏢IPadView {
    private static func placeholderView() -> some View {
        Label("Select sidebar", systemImage: "arrowshape.left")
            .font(.title)
            .foregroundStyle(.tertiary)
    }
}

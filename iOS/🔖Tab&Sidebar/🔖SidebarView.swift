import SwiftUI

struct 🔖SidebarView: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        List(🔖Sidebar.allCases,
             selection: self.$model.selectedSidebar,
             rowContent: \.link)
        .background(ignoresSafeAreaEdges: .all)
        .navigationSplitViewColumnWidth(280) //default: 320
        .environment(\.defaultMinListRowHeight, 50)
        .toolbar { self.bottomBarButtons() }
    }
}

private extension 🔖SidebarView {
    private func bottomBarButtons() -> some ToolbarContent {
        ToolbarItemGroup(placement: .bottomBar) {
            Button {
                self.model.presentSheet(.aboutApp)
            } label: {
                Label("App", systemImage: "info.circle")
            }
            Spacer()
            Button {
                self.model.presentSheet(.purchase)
            } label: {
                Label("Purchase", systemImage: "cart")
            }
        }
    }
}

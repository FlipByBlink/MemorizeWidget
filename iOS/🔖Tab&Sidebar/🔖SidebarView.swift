import SwiftUI

struct 🔖SidebarView: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        List(selection: self.$model.selectedSidebar) {
            ForEach(🔖Sidebar.allCases) { $0.navigationLink() }
        }
        .background(ignoresSafeAreaEdges: .all)
        .navigationSplitViewColumnWidth(280) //default: 320
        .environment(\.defaultMinListRowHeight, 50)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.visible, for: .navigationBar)
        .toolbar { self.bottomBarButtons() }
    }
}

private extension 🔖SidebarView {
    private func bottomBarButtons() -> some ToolbarContent {
        ToolbarItemGroup(placement: .bottomBar) {
            Button {
                self.model.presentSheetOnContentView(.aboutApp)
            } label: {
                Label("App", systemImage: "info.circle")
            }
            Spacer()
            Button {
                self.model.presentSheetOnContentView(.purchase)
            } label: {
                Label("Purchase", systemImage: "cart")
            }
        }
    }
}

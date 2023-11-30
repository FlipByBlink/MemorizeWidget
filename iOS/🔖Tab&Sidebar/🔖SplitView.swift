import SwiftUI

struct 🔖SplitView: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        NavigationSplitView {
            List(selection: self.$model.selectedSidebar) {
                ForEach(🔖Sidebar.allCases) { $0.navigationLink() }
            }
            .background(ignoresSafeAreaEdges: .all)
            .navigationSplitViewColumnWidth(280) //default: 320
            .environment(\.defaultMinListRowHeight, 50)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(.visible, for: .navigationBar)
            .toolbar { self.bottomBarButtons() }
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

private extension 🔖SplitView {
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
    private static func placeholderView() -> some View {
        Label("Select sidebar", systemImage: "arrowshape.left")
            .font(.title)
            .foregroundStyle(.tertiary)
    }
}

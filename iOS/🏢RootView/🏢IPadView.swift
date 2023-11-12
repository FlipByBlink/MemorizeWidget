import SwiftUI

//TODO: 要再検討。horizontalSizeClassでの切り替えだとバックグラウンド移行時にViewがリセットされてscrollやnavigationがリセットされてしまうので一旦コメントアウトした。

struct 🏢IPadView: View {
//    @EnvironmentObject var model: 📱AppModel
//    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var body: some View {
        Self.SplitView()
//        Group {
//            switch self.horizontalSizeClass {
//                case .compact: 🔖TabView()
//                case .regular: Self.SplitView()
//                default: 🔖TabView()
//            }
//        }
//        .onChange(of: self.horizontalSizeClass) {
//            self.model.switchLayout($0)
//        }
    }
}

private extension 🏢IPadView {
    private struct SplitView: View {
        @EnvironmentObject var model: 📱AppModel
        var body: some View {
            NavigationSplitView {
                List(🔖Sidebar.allCases,
                     selection: self.$model.selectedSidebar,
                     rowContent: \.link)
                .background(ignoresSafeAreaEdges: .all)
                .navigationSplitViewColumnWidth(280) //default: 320
                .environment(\.defaultMinListRowHeight, 50)
                .toolbar {
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
            } detail: {
                if let ⓢelectedSidebar = self.model.selectedSidebar {
                    ⓢelectedSidebar.detailView
                } else {
                    📚NotesListTab() //spare
                }
            }
            .navigationSplitViewStyle(.balanced)
        }
    }
}

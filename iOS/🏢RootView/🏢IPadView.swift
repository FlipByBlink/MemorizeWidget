import SwiftUI

//TODO: 要再検討。horizontalSizeClassでの切り替えだとバックグラウンド移行時にViewがリセットされてscrollやnavigationがリセットされてしまうので一旦コメントアウトした。

struct 🏢IPadView: View {
    @EnvironmentObject var model: 📱AppModel
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
        @State private var columnVisibility: NavigationSplitViewVisibility = .all
        var body: some View {
            NavigationSplitView(columnVisibility: self.$columnVisibility) {
                List(selection: self.$model.selectedSidebar) {
                    ForEach(🔖Tab.allCases) { $0.label() }
                }
                .modifier(🔢NotesCountText.BottomToolbar())
                .background(ignoresSafeAreaEdges: .all)
                .navigationSplitViewColumnWidth(280) //default: 320
            } detail: {
                self.model.selectedSidebar?.detailView
                Self.Workaround.SpareDetailView()
            }
            .navigationSplitViewStyle(.balanced)
        }
        private enum Workaround {
            struct SpareDetailView: View {
                @EnvironmentObject var model: 📱AppModel
                var body: some View {
                    if self.model.selectedSidebar == nil {
                        📚NotesListTab()
                    }
                }
            }
        }
    }
}

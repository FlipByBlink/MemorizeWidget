import SwiftUI

struct 🏢RootView: View {
    var body: some View {
        switch UIDevice.current.userInterfaceIdiom {
            case .pad: Self.IPadView()
            default: 🔖TabView()
        }
    }
}

private extension 🏢RootView {
    private struct IPadView: View {
        @EnvironmentObject var model: 📱AppModel
        @Environment(\.horizontalSizeClass) var horizontalSizeClass
        @State private var columnVisibility: NavigationSplitViewVisibility = .all
        var body: some View {
            Group {
                switch self.horizontalSizeClass {
                    case .compact:
                        🔖TabView()
                    case .regular:
                        NavigationSplitView(columnVisibility: self.$columnVisibility) {
                            List(selection: self.$model.selectedSidebar) {
                                ForEach(🔖Tab.allCases) { $0.label() }
                            }
                        } detail: {
                            if let selectedSidebar = self.model.selectedSidebar {
                                selectedSidebar.detailView
                            } else {
                                📚NotesListTab()
                            }
                        }
                        .navigationSplitViewStyle(.balanced)
                    default:
                        🔖TabView()
                }
            }
            .onChange(of: self.horizontalSizeClass) {
                self.model.switchLayout($0)
            }
        }
    }
}

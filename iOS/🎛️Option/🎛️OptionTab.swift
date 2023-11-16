import SwiftUI

struct 🎛️OptionTab: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        NavigationStack {
            List {
                🎛️MultiNotesOnWidgetOption()
                🎛️CommentOnWidgetOption()
                self.fontSizeMenuLink()
                self.customizeSearchLink()
            }
            .navigationTitle("Option")
        }
    }
}

private extension 🎛️OptionTab {
    private func fontSizeMenuLink() -> some View {
        Group {
            switch UIDevice.current.userInterfaceIdiom {
                case .phone:
                    NavigationLink {
                        🎛️FontSizeOptionMenu()
                    } label: {
                        Label("Customize font size", systemImage: "textformat.size")
                    }
                case .pad:
                    Button {
                        self.model.presentSheet(.customizeFontSize)
                    } label: {
                        Label("Customize font size", systemImage: "textformat.size")
                    }
                default:
                    EmptyView()
            }
        }
    }
    private func customizeSearchLink() -> some View {
        Section {
            switch UIDevice.current.userInterfaceIdiom {
                case .phone:
                    NavigationLink {
                        🔍CustomizeSearchMenu()
                    } label: {
                        Label("Customize search function", systemImage: "magnifyingglass")
                    }
                case .pad:
                    Button {
                        self.model.presentSheet(.customizeSearch)
                    } label: {
                        Label("Customize search function", systemImage: "magnifyingglass")
                    }
                default:
                    EmptyView()
            }
        }
    }
}

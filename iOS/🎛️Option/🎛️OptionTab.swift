import SwiftUI

struct 🎛️OptionTab: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        NavigationStack {
            List {
                🎛️MultiNotesOnWidgetOption()
                🎛️CommentOnWidgetOption()
                🎛️ViewComponent.MultilineTextAlignmentPicker()
                self.fontSizeMenuLink()
                self.customizeSearchLink()
            }
            .navigationTitle("Option")
        }
    }
}

private extension 🎛️OptionTab {
    private func fontSizeMenuLink() -> some View {
        Section {
            switch UIDevice.current.userInterfaceIdiom {
                case .phone:
                    NavigationLink {
                        🎛️FontSizeOptionMenu()
                    } label: {
                        Label("Customize font size", systemImage: "textformat.size")
                    }
                case .pad:
                    Button {
                        self.model.presentSheetOnContentView(.customizeFontSize)
                    } label: {
                        Label("Customize font size…", systemImage: "textformat.size")
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
                        self.model.presentSheetOnContentView(.customizeSearch)
                    } label: {
                        Label("Customize search function…", systemImage: "magnifyingglass")
                    }
                default:
                    EmptyView()
            }
        } header: {
            Text("Rest")
        }
    }
}

import SwiftUI

struct 🎛️OptionTab: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        NavigationStack {
            List {
                self.fontSizeMenuLink() //TODO: ちゃんと実装
                🎛️MultiNotesOnWidgetOption()
                🎛️CommentOnWidgetOption()
                🔍CustomizeSearchSheetButton()
                self.fontSizeMenuLink()
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
}

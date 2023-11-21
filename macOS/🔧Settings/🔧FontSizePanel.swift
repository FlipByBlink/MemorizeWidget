import SwiftUI

struct 🔧FontSizePanel: View {
    var body: some View {
        Form {
            Spacer()
            🎛️ViewComponent.FontSize.CustomizeToggle()
                .labelStyle(.titleOnly)
                .toggleStyle(.switch)
            Spacer()
            🎛️ViewComponent.FontSize.TitleForSystemFamilyPicker()
            🎛️ViewComponent.FontSize.CommentForSystemFamilyPicker()
            Spacer()
        }
        .padding(96)
        .tabItem {
            Label("Font", systemImage: "textformat.size")
        }
    }
}

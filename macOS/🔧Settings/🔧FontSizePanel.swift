import SwiftUI

struct 🔧FontSizePanel: View {
    @AppStorage(🎛️Key.FontSize.customize, store: .ⓐppGroup) var customizeFontSize: Bool = false
    var body: some View {
        Form {
            🎛️ViewComponent.FontSize.CustomizeToggle()
                .labelStyle(.titleOnly)
                .toggleStyle(.switch)
            Spacer(minLength: 36)
            Group {
                🎛️ViewComponent.FontSize.TitleForSystemFamilyPicker()
                🎛️ViewComponent.FontSize.CommentForSystemFamilyPicker()
            }
            .disabled(!self.customizeFontSize)
        }
        .padding(96)
        .padding(.vertical, 32)
        .tabItem {
            Label("Font", systemImage: "textformat.size")
        }
    }
}

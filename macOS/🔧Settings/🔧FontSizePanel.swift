import SwiftUI

struct 🔧FontSizePanel: View {
    @AppStorage(🎛️Key.FontSize.customize, store: .ⓐppGroup) var customizeFontSize: Bool = false
    var body: some View {
        Form {
            Spacer()
            🎛️ViewComponent.FontSize.CustomizeToggle()
                .labelStyle(.titleOnly)
                .toggleStyle(.switch)
            Spacer(minLength: 36)
            Group {
                🎛️ViewComponent.FontSize.TitleForSystemFamilyPicker()
                🎛️ViewComponent.FontSize.CommentForSystemFamilyPicker()
            }
            .disabled(!self.customizeFontSize)
            Spacer()
        }
        .padding(96)
        .tabItem {
            Label("Font", systemImage: "textformat.size")
        }
    }
}

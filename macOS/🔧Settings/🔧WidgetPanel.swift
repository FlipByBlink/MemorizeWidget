import SwiftUI

struct 🔧WidgetPanel: View {
    @AppStorage(🎛️Key.FontSize.customize, store: .ⓐppGroup) var customizeFontSize: Bool = false
    var body: some View {
        Form {
            Section {
                🎛️RandomModeToggle()
            } footer: {
                🎛️RandomModeToggle.Caption()
                    .foregroundStyle(.secondary)
            }
            Section {
                🎛️ViewComponent.MultiNotesToggle()
                🎛️ViewComponent.ShowCommentToggle()
                🎛️ViewComponent.MultilineTextAlignmentPicker()
            }
            Section {
                🎛️ViewComponent.FontSize.CustomizeToggle()
                if self.customizeFontSize {
                    🎛️ViewComponent.FontSize.TitleForSystemFamilyPicker()
                    🎛️ViewComponent.FontSize.CommentForSystemFamilyPicker()
                }
            }
        }
        .formStyle(.grouped)
        .animation(.default, value: self.customizeFontSize)
        .tabItem {
            Label("Widget", systemImage: "rectangle.3.group")
        }
    }
}

import SwiftUI

struct 🎛️FontSizeMenu: View {
    @AppStorage(🎛️Key.FontSize.AccessoryFamily.title, store: .ⓐppGroup)
    var titleValue: Int = 🎛️Default.FontSize.AccessoryFamily.title
    
    @AppStorage(🎛️Key.FontSize.AccessoryFamily.comment, store: .ⓐppGroup)
    var commentValue: Int = 🎛️Default.FontSize.AccessoryFamily.comment
    
    @AppStorage(🎛️Key.FontSize.customize, store: .ⓐppGroup)
    var customizeFontSize: Bool = false
    
    var body: some View {
        List {
            🎛️ViewComponent.FontSize.CustomizeToggle()
            Section {
                🎛️ViewComponent.FontSize.TitleForAccessoryFamilyPicker()
                🎛️ViewComponent.FontSize.CommentForAccessoryFamilyPicker()
            }
            .disabled(!self.customizeFontSize)
            .animation(.default.speed(2), value: self.customizeFontSize)
            Section {
                ZStack {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(.white)
                        .shadow(color: .gray, radius: 3)
                    VStack(spacing: 2) {
                        Text("(TITLE)")
                            .font(.system(size: CGFloat(self.titleValue), weight: .bold))
                            .foregroundStyle(.purple)
                        Text("(Comment)")
                            .font(.system(size: CGFloat(self.commentValue), weight: .light))
                            .foregroundStyle(.green)
                    }
                }
                .frame(height: 76)
                .listRowBackground(Color.clear)
                .animation(.default, value: self.titleValue)
                .animation(.default, value: self.commentValue)
            } header: {
                Text("Preview")
            } footer: {
                🎛️ViewComponent.FontSize.NoticeText()
            }
        }
        .navigationTitle("Font size")
    }
}

import SwiftUI

struct 🎛️CommentOnWidgetOption: View {
    var body: some View {
        Section {
            🎛️ViewComponent.ShowCommentToggle()
                    .padding(.vertical, 8)
            VStack(spacing: 12) {
                🎛️BeforeAfterImages(.systemFamilyDefault, .systemFamilyShowComment)
                if UIDevice.current.userInterfaceIdiom == .phone {
//                    🎛️BeforeAfterImages("lockscreen_commentOff", "lockscreen_commentOn")
                }
            }
            .padding()
        }
    }
}

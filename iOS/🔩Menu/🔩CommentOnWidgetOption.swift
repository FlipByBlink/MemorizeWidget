import SwiftUI

struct 🔩CommentOnWidgetOption: View {
    var body: some View {
        Section {
            🔩MenuViewComponent.ShowCommentToggle()
                    .padding(.vertical, 8)
            VStack(spacing: 12) {
                🔩BeforeAfterImages("homeSmall_commentOff", "homeSmall_commentOn")
                if UIDevice.current.userInterfaceIdiom == .phone {
                    🔩BeforeAfterImages("lockscreen_commentOff", "lockscreen_commentOn")
                }
            }
            .padding()
        }
    }
}

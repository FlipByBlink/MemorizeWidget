import SwiftUI

struct 🎛️CommentOnWidgetOption: View {
    var body: some View {
        Section {
            🎛️ViewComponent.ShowCommentToggle()
                    .padding(.vertical, 8)
            VStack(spacing: 16) {
                🎛️BeforeAfterImages(.systemFamilyDefault, .systemFamilyShowComment)
                if Self.showAccessoryFamilyPreview {
                    🎛️BeforeAfterImages(.accessoryFamilyDefault, .accessoryFamilyShowComment)
                }
            }
            .padding()
        }
    }
}

private extension 🎛️CommentOnWidgetOption {
    private static var showAccessoryFamilyPreview: Bool {
        if #available(iOS 17.0, *) {
            true
        } else {
            UIDevice.current.userInterfaceIdiom == .phone
        }
    }
}

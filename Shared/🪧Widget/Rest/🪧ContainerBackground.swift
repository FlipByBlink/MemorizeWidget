import SwiftUI

struct 🪧ContainerBackground: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 17.0, watchOS 10.0, macOS 14.0, *) {
            content.containerBackground(.background, for: .widget)
        } else {
            content
        }
    }
}

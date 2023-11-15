import SwiftUI

struct 🪧PlaceholderView: View {
    var body: some View {
        Image(systemName: "book.closed")
            .foregroundStyle(.tertiary)
            .modifier(🪧ContainerBackground())
    }
}

import SwiftUI

struct 🪧PlaceholderView: View {
    var body: some View {
        VStack(spacing: 2) {
            Text(verbatim: "Placeholder")
                .font(.system(size: 26))
            Text(verbatim: "Placeholder")
                .font(.system(size: 15))
                .foregroundStyle(.secondary)
        }
        .modifier(🪧ContainerBackground())
    }
}

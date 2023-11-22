import SwiftUI

struct 🪧PlaceholderView: View {
    var body: some View {
        VStack(spacing: 6) {
            Text(verbatim: "Placeholder")
                .font(.title)
            Text(verbatim: "Placeholder")
        }
        .modifier(🪧ContainerBackground())
    }
}

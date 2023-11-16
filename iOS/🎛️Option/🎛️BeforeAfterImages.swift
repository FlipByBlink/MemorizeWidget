import SwiftUI

struct 🎛️BeforeAfterImages: View {
    private var before: ImageResource
    private var after: ImageResource
    var body: some View {
        HStack {
            Image(self.before)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Image(systemName: "arrow.right")
                .font(.title2.weight(.semibold))
                .foregroundStyle(.secondary)
            Image(self.after)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        .frame(maxHeight: 170)
        .environment(\.layoutDirection, .leftToRight)
    }
    init(_ before: ImageResource, _ after: ImageResource) {
        self.before = before
        self.after = after
    }
}

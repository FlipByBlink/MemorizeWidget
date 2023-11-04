import SwiftUI

struct 🔩BeforeAfterImages: View {
    private var before: String
    private var after: String
    var body: some View {
        HStack {
            Image(self.before)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 200)
                .cornerRadius(16)
                .shadow(radius: 2)
            Image(systemName: "arrow.right")
                .font(.title2.weight(.semibold))
                .foregroundStyle(.secondary)
            Image(self.after)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 200)
                .cornerRadius(16)
                .shadow(radius: 2)
        }
    }
    init(_ before: String, _ after: String) {
        self.before = before
        self.after = after
    }
}

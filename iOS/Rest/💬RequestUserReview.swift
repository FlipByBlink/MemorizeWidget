import SwiftUI

struct 💬RequestUserReview: ViewModifier {
    @Environment(\.requestReview) var requestReview
    @AppStorage("launchCount") var launchCount: Int = 0
    func body(content: Content) -> some View {
        content
            .task {
                self.launchCount += 1
                if [20, 50, 100, 200].contains(self.launchCount) {
                    self.requestReview()
                }
            }
    }
}

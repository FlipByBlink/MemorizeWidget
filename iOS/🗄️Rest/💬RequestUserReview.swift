import SwiftUI

struct 💬RequestUserReview: ViewModifier {//アプリ毎に個別に実装する
    @Environment(\.requestReview) var requestReview
    @AppStorage("launchCount") private var launchCount: Int = 0
    func body(content: Content) -> some View {
        content
            .task {
                self.launchCount += 1
                if [10, 30, 50, 70, 90].contains(self.launchCount) {
                    self.requestReview()
                }
            }
    }
}

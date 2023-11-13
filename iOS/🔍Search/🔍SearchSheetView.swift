import SwiftUI
import SafariServices

struct 🔍SearchSheetView: View {
    var url: URL
    var body: some View {
        Self.UIKitView(url: self.url)
            .ignoresSafeArea()
            .presentationDetents([.height(640)])
    }
    init(_ url: URL) {
        self.url = url
    }
}

private extension 🔍SearchSheetView {
    struct UIKitView: UIViewControllerRepresentable {
        var url: URL
        func makeUIViewController(context: Context) -> SFSafariViewController {
            .init(url: self.url)
        }
        func updateUIViewController(_ uiViewController: SFSafariViewController,
                                    context: Context) {
            /* Nothing to do */
        }
    }
}

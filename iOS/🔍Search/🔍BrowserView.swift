import SwiftUI
import SafariServices

struct 🔍BrowserView: UIViewControllerRepresentable {
    var url: URL
    func makeUIViewController(context: Context) -> SFSafariViewController {
        .init(url: self.url)
    }
    func updateUIViewController(_ uiViewController: SFSafariViewController,
                                context: Context) {
        /* Nothing to do */
    }
}

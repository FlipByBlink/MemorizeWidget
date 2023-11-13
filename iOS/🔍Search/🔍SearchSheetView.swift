import SwiftUI
import SafariServices

struct 🔍SearchSheetView: View {
    private var viewController: SFSafariViewController
    var body: some View {
        Self.BrowserView(viewController: self.viewController)
            .ignoresSafeArea()
            .presentationDetents([.medium, .large])
            //.frame(minWidth: 360, minHeight: 420) for popover
    }
    init(_ viewController: SFSafariViewController) {
        self.viewController = viewController
    }
}

private extension 🔍SearchSheetView {
    private struct BrowserView: UIViewControllerRepresentable {
        var viewController: SFSafariViewController
        func makeUIViewController(context: Context) -> SFSafariViewController {
            self.viewController
        }
        func updateUIViewController(_ uiViewController: SFSafariViewController,
                                    context: Context) {
            /* Nothing to do */
        }
    }
}

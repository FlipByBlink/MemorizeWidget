import SwiftUI

struct 📘DictionarySheetView: View {
    private var viewController: UIReferenceLibraryViewController
    var body: some View {
        Self.UIKitView(viewController: self.viewController)
            .ignoresSafeArea()
            .presentationDetents([.height(640)])
    }
    init(_ referenceLibraryViewController: UIReferenceLibraryViewController) {
        self.viewController = referenceLibraryViewController
    }
}

private extension 📘DictionarySheetView {
    private struct UIKitView: UIViewControllerRepresentable {
        var viewController: UIReferenceLibraryViewController
        func makeUIViewController(context: Context) -> UIReferenceLibraryViewController {
            self.viewController
        }
        func updateUIViewController(_ uiViewController: UIReferenceLibraryViewController,
                                    context: Context) {
            /* Nothing to do */
        }
    }
}

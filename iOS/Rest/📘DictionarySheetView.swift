import SwiftUI

struct 📘DictionarySheetView: View {
    private var referenceLibraryViewController: UIReferenceLibraryViewController
    var body: some View {
        🅄IReferenceLibraryView(self.referenceLibraryViewController)
            .ignoresSafeArea()
            .presentationDetents([.medium])
    }
    init(_ referenceLibraryViewController: UIReferenceLibraryViewController) {
        self.referenceLibraryViewController = referenceLibraryViewController
    }
}

private struct 🅄IReferenceLibraryView: UIViewControllerRepresentable {
    private var referenceLibraryViewController: UIReferenceLibraryViewController
    func makeUIViewController(context: Context) -> UIReferenceLibraryViewController {
        self.referenceLibraryViewController
    }
    func updateUIViewController(_ uiViewController: UIReferenceLibraryViewController,
                                context: Context) {
        /* Nothing to do */
    }
    init(_ referenceLibraryViewController: UIReferenceLibraryViewController) {
        self.referenceLibraryViewController = referenceLibraryViewController
    }
}

import SwiftUI

struct 📘DictionaryView: View {
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
    func updateUIViewController(_ uiViewController: UIReferenceLibraryViewController, context: Context) {
        /* Nothing to do */
    }
    init(_ referenceLibraryViewController: UIReferenceLibraryViewController) {
        self.referenceLibraryViewController = referenceLibraryViewController
    }
}

struct 📘DictionaryButtonOnMac: View {
    @Environment(\.openURL) var openURL
    var term: String
    var body: some View {
        Button {
            guard let ⓟath = self.term.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed),
                  let ⓤrl = URL(string: "dict://" + ⓟath) else {
                return
            }
            self.openURL(ⓤrl)
        } label: {
            Label("Dictionary", systemImage: "character.book.closed")
        }
    }
}

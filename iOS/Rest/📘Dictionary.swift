import SwiftUI

struct 📘DictionaryView: View {
    var referenceLibraryViewController: UIReferenceLibraryViewController
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
    private var viewController: UIReferenceLibraryViewController
    func makeUIViewController(context: Context) -> UIReferenceLibraryViewController {
        self.viewController
    }
    func updateUIViewController(_ uiViewController: UIReferenceLibraryViewController, context: Context) {
        //Nothing to do
    }
    init(_ viewController: UIReferenceLibraryViewController) {
        self.viewController = viewController
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

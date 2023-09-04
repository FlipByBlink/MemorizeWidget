import SwiftUI

struct 📘DictionaryState {
    var showSheet: Bool
    var viewController: UIReferenceLibraryViewController?
    static var `default`: Self { Self(showSheet: false, viewController: nil) }
    mutating func request(_ ⓣerm: String) {
        self.viewController = UIReferenceLibraryViewController(term: ⓣerm)
        self.showSheet = true
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
}

struct 📘DictionarySheet: ViewModifier {
    @Binding private var ⓢtate: 📘DictionaryState
    func body(content: Content) -> some View {
        let ⓥiewController = self.ⓢtate.viewController
        content
            .sheet(isPresented: self.$ⓢtate.showSheet) {
                if let ⓥiewController {
                    🄳ictinaryView(ⓥiewController)
                        .ignoresSafeArea()
                }
            }
    }
    init(_ state: Binding<📘DictionaryState>) {
        self._ⓢtate = state
    }
}

private struct 🄳ictinaryView: UIViewControllerRepresentable {
    private var ⓥiewController: UIReferenceLibraryViewController
    func makeUIViewController(context: Context) -> UIReferenceLibraryViewController {
        self.ⓥiewController
    }
    func updateUIViewController(_ uiViewController: UIReferenceLibraryViewController, context: Context) {
        //Nothing to do
    }
    init(_ viewController: UIReferenceLibraryViewController) {
        self.ⓥiewController = viewController
    }
}

struct 📘DictionaryButtonOnMac: View {
    @Environment(\.openURL) private var openURL
    var term: String
    private var ⓤrl: URL? {
        if let ⓟath = self.term.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) {
            return URL(string: "dict://" + ⓟath)
        } else {
            return nil
        }
    }
    var body: some View {
        Button {
            if let ⓤrl {
                self.openURL(ⓤrl)
            }
        } label: {
            Label("Dictionary", systemImage: "character.book.closed")
        }
    }
}

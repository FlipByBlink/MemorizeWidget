import SwiftUI

struct 📘DictionaryState {
    var showSheet: Bool
    var viewController: UIReferenceLibraryViewController?
    static var `default`: Self { .init(showSheet: false, viewController: nil) }
    mutating func request(_ ⓣerm: String) {
        self.viewController = UIReferenceLibraryViewController(term: ⓣerm)
        self.showSheet = true
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
}

struct 📘DictionarySheet: ViewModifier {
    @Binding private var dictionaryState: 📘DictionaryState
    func body(content: Content) -> some View {
        let ⓥiewController = self.dictionaryState.viewController
        content
            .sheet(isPresented: self.$dictionaryState.showSheet) {
                if let ⓥiewController {
                    🄳ictinaryView(ⓥiewController)
                        .ignoresSafeArea()
                }
            }
    }
    init(_ state: Binding<📘DictionaryState>) {
        self._dictionaryState = state
    }
}

private struct 🄳ictinaryView: UIViewControllerRepresentable {
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
    private var ⓤrl: URL? {
        if let ⓟath = self.term.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) {
            URL(string: "dict://" + ⓟath)
        } else {
            nil
        }
    }
    var body: some View {
        Button {
            if let ⓤrl { self.openURL(ⓤrl) }
        } label: {
            Label("Dictionary", systemImage: "character.book.closed")
        }
    }
}

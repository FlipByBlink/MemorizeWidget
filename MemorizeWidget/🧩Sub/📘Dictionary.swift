import SwiftUI

struct 📘DictionaryState {
    var showSheet: Bool = false
    var viewController: UIReferenceLibraryViewController?
    mutating func request(_ ⓣerm: String) {
        self.viewController = UIReferenceLibraryViewController(term: ⓣerm)
        self.showSheet = true
    }
}

struct 📘DictionarySheet: ViewModifier {
    @Binding private var ⓢtate: 📘DictionaryState
    func body(content: Content) -> some View {
        content
            .popover(isPresented: self.$ⓢtate.showSheet) {
                if let ⓥiewController = self.ⓢtate.viewController {
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

import SwiftUI

struct 📗DictionarySheet: ViewModifier {
    private let ⓣerm: String
    @Binding private var 🚩showSheet: Bool
    func body(content: Content) -> some View {
        content
            .popover(isPresented: self.$🚩showSheet) {
                🄳ictinaryView(self.ⓣerm)
                    .ignoresSafeArea()
            }
    }
    init(_ note: 📗Note, _ showSheet: Binding<Bool>) {
        self.ⓣerm = note.title
        self._🚩showSheet = showSheet
    }
}

private struct 🄳ictinaryView: UIViewControllerRepresentable {
    private var ⓣerm: String
    func makeUIViewController(context: Context) -> UIReferenceLibraryViewController {
        UIReferenceLibraryViewController(term: self.ⓣerm)
    }
    func updateUIViewController(_ uiViewController: UIReferenceLibraryViewController, context: Context) {
        //Nothing to do
    }
    init(_ term: String) {
        self.ⓣerm = term
    }
}

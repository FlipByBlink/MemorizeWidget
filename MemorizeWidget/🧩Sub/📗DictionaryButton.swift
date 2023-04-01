import SwiftUI

struct 📗DictionaryButton: View {
    @Binding private var 🚩showSheet: Bool
    var body: some View {
        Button {
            self.🚩showSheet = true
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        } label: {
            Label("Dictionary", systemImage: "character.book.closed")
        }
    }
    init(_ showSheet: Binding<Bool>) {
        self._🚩showSheet = showSheet
    }
}

struct 📗DictionarySheet: ViewModifier {
    private let ⓣerm: String
    @Binding private var 🚩showSheet: Bool
    func body(content: Content) -> some View {
        content
            .popover(isPresented: self.$🚩showSheet) {
                🄳ictinaryView(term: self.ⓣerm)
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
    func updateUIViewController(_ uiViewController: UIReferenceLibraryViewController, context: Context) {}
    init(term: String) {
        self.ⓣerm = term
    }
}

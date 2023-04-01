import SwiftUI

struct 📗DictionaryButton: View {
    private let ⓣerm: String
    @State private var 🚩showSheet: Bool = false
    var body: some View {
        Button {
            self.🚩showSheet = true
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        } label: {
            Label("Dictionary", systemImage: "character.book.closed")
                .padding(8)
        }
        .popover(isPresented: self.$🚩showSheet) {
            🄳ictinaryView(term: self.ⓣerm)
                .ignoresSafeArea()
        }
    }
    init(_ note: 📗Note) {
        self.ⓣerm = note.title
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

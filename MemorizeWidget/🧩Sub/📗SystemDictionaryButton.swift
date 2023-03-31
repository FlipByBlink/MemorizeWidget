import SwiftUI

struct 📗SystemDictionaryButton: View {
    @EnvironmentObject var 📱: 📱AppModel
    @State private var 🚩showSystemDictionary: Bool = false
    private var ⓣerm: String
    var body: some View {
        Button {
            self.🚩showSystemDictionary = true
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        } label: {
            Label("Dictionary", systemImage: "character.book.closed")
        }
        .sheet(isPresented: self.$🚩showSystemDictionary) {
            📗SystemDictionarySheet(self.ⓣerm)
        }
    }
    init(_ note: 📗Note) {
        self.ⓣerm = note.title
    }
}

private struct 📗SystemDictionarySheet: View {
    private var ⓣerm: String
    var body: some View {
        Self.🄳ictinaryView(term: self.ⓣerm)
            .ignoresSafeArea()
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
    init(_ term: String) {
        self.ⓣerm = term
    }
}

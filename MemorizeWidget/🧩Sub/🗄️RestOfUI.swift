import SwiftUI

struct 🛒PurchaseTab: View {
    @EnvironmentObject var 🛒: 🛒StoreModel
    var body: some View {
        NavigationView { 📣ADMenu() }
            .navigationViewStyle(.stack)
    }
}

struct 📗SystemDictionaryButton: View {
    @EnvironmentObject var 📱: 📱AppModel
    @State private var 🚩showSystemDictionary: Bool = false
    private var 🔢noteIndex: Int
    var body: some View {
        Button {
            self.🚩showSystemDictionary = true
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        } label: {
            Label("Dictionary", systemImage: "character.book.closed")
                .labelStyle(.iconOnly)
        }
        .sheet(isPresented: self.$🚩showSystemDictionary) {
            Self.📗SystemDictionarySheet(term: 📱.📚notes[self.🔢noteIndex].title)
        }
    }
    init(_ noteIndex: Int) {
        self.🔢noteIndex = noteIndex
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
        init(term: String) {
            self.ⓣerm = term
        }
    }
}

struct 🔍SearchButton: View {
    @EnvironmentObject var 📱: 📱AppModel
    @AppStorage("SearchLeadingText") var 🔗leading: String = ""
    @AppStorage("SearchTrailingText") var 🔗trailing: String = ""
    @Environment(\.openURL) var openURL
    private var 🔢noteIndex: Int
    var body: some View {
        Button {
            self.ⓐction()
        } label: {
            Label("Search", systemImage: "magnifyingglass")
                .labelStyle(.iconOnly)
        }
    }
    private func ⓐction() {
        let ⓛeading = self.🔗leading.isEmpty ? "https://duckduckgo.com/?q=" : self.🔗leading
        let ⓣext = ⓛeading + 📱.📚notes[self.🔢noteIndex].title + self.🔗trailing
        guard let ⓔncodedText = ⓣext.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        guard let ⓤrl = URL(string: ⓔncodedText) else { return }
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        self.openURL(ⓤrl)
    }
    init(_ noteIndex: Int) {
        self.🔢noteIndex = noteIndex
    }
}

struct 💾OperateData: ViewModifier {
    @EnvironmentObject var 📱: 📱AppModel
    @AppStorage("savedDataByShareExtension", store: 💾AppGroupUD) private var 🚩savedDataByShareExtension: Bool = false
    func body(content: Content) -> some View {
        content
            .onChange(of: 📱.📚notes) { _ in
                📱.saveNotes()
            }
            .onAppear {
                self.🚩savedDataByShareExtension = false
            }
            .onChange(of: self.🚩savedDataByShareExtension) {
                if $0 == true {
                    📱.loadNotes()
                    self.🚩savedDataByShareExtension = false
                }
            }
    }
}

//MARK: - REJECT .defaultAppStorage(UserDefaults(suiteName: `AppGroupID`)!)
//reason: buggy list-animation on iOS15.x

import SwiftUI

struct 📖WidgetNotesSheet: ViewModifier {
    @EnvironmentObject var 📱: 📱AppModel
    @EnvironmentObject var 🛒: 🛒StoreModel
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $📱.🪧widgetState.showSheet) {
                📖WidgetNotesView()
                    .environmentObject(📱)
                    .environmentObject(🛒)
            }
    }
}

private struct 📖WidgetNotesView: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        NavigationView {
            Group {
                if 📱.🪧widgetState.info?.targetedNotesCount == 1 {
                    Self.🅂igleNoteLayout()
                } else {
                    Self.🄼ultiNotesLayout()
                }
            }
            .toolbar { 🅧DismissButton() }
        }
        .modifier(📣ADSheet())
        .navigationViewStyle(.stack)
    }
    private struct 🅂igleNoteLayout: View {
        @EnvironmentObject var 📱: 📱AppModel
        private var ⓘndex: Int? { 📱.📚notes.index(📱.🪧widgetState.info?.targetedNoteIDs?.first) }
        var body: some View {
            VStack {
                Spacer()
                if let ⓘndex {
                    📓NoteView($📱.📚notes[ⓘndex], layout: .widgetSheet_single)
                        .padding(.horizontal, 32)
                    Spacer()
                    HStack {
                        Spacer()
                        📘DictionaryButton(📱.📚notes[ⓘndex])
                        Spacer()
                        🔍SearchButton(📱.📚notes[ⓘndex])
                        Spacer()
                        🚮DeleteNoteButton(📱.📚notes[ⓘndex])
                        Spacer()
                    }
                    .labelStyle(.iconOnly)
                    .buttonStyle(.plain)
                    .foregroundColor(.primary)
                    .font(.title)
                    .padding(.horizontal, 24)
                } else {
                    🚮DeletedNoteView()
                        .padding(.bottom, 24)
                }
                Spacer()
            }
        }
    }
    private struct 🄼ultiNotesLayout: View {
        @EnvironmentObject var 📱: 📱AppModel
        private var ⓘds: [UUID] { 📱.🪧widgetState.info?.targetedNoteIDs ?? [] }
        private var ⓣargetNotesCount: Int { 📱.🪧widgetState.info?.targetedNotesCount ?? 0 }
        private var ⓓeletedAll: Bool {
            self.ⓘds.allSatisfy { ⓘd in
                !📱.📚notes.contains { $0.id == ⓘd }
            }
        }
        var body: some View {
            List {
                if self.ⓣargetNotesCount < 4 {
                    ForEach(self.ⓘds, id: \.self) { ⓘd in
                        Section { self.ⓝoteRow(ⓘd) }
                    }
                } else {
                    Section {
                        ForEach(self.ⓘds, id: \.self) { self.ⓝoteRow($0) }
                    }
                }
                if self.ⓓeletedAll {
                    Section { 🚮DeletedNoteView() }
                }
            }
        }
        private func ⓝoteRow(_ ⓘd: UUID) -> some View {
            Group {
                if let ⓘndex = 📱.📚notes.index(ⓘd) {
                    VStack(spacing: 0) {
                        📓NoteView($📱.📚notes[ⓘndex], layout: .widgetSheet_multi)
                        HStack {
                            Spacer()
                            📘DictionaryButton(📱.📚notes[ⓘndex])
                            Spacer()
                            🔍SearchButton(📱.📚notes[ⓘndex])
                            Spacer()
                            🚮DeleteNoteButton(📱.📚notes[ⓘndex])
                            Spacer()
                        }
                        .labelStyle(.iconOnly)
                        .buttonStyle(.plain)
                        .foregroundColor(.primary)
                        .font(.title3)
                        .padding(12)
                    }
                    .padding(8)
                }
            }
        }
    }
}

private struct 📘DictionaryButton: View {
    private var ⓣerm: String
    @State private var ⓢtate: 📘DictionaryState = .default
    var body: some View {
#if !targetEnvironment(macCatalyst)
        Button {
            self.ⓢtate.request(self.ⓣerm)
        } label: {
            Label("Dictionary", systemImage: "character.book.closed")
        }
        .modifier(📘DictionarySheet(self.$ⓢtate))
#else
        📘DictionaryButtonOnMac(term: self.ⓣerm)
#endif
    }
    init(_ note: 📗Note) {
        self.ⓣerm = note.title
    }
}

private struct 🚮DeletedNoteView: View {
    var body: some View {
        HStack {
            Spacer()
            VStack(spacing: 24) {
                Label("Deleted.", systemImage: "checkmark")
                Image(systemName: "trash")
            }
            .foregroundColor(.primary)
            .imageScale(.small)
            .font(.largeTitle)
            Spacer()
        }
        .padding(24)
    }
}

private struct 🅧DismissButton: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        Button {
            📱.🪧widgetState.showSheet = false
            UISelectionFeedbackGenerator().selectionChanged()
        } label: {
            Image(systemName: "xmark.circle.fill")
                .symbolRenderingMode(.hierarchical)
        }
        .foregroundColor(.secondary)
        .keyboardShortcut(.cancelAction)
    }
}

private struct 📣ADSheet: ViewModifier {
    @EnvironmentObject var 🛒: 🛒StoreModel
    @State private var ⓐpp: 📣MyApp = .pickUpAppWithout(.MemorizeWidget)
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $🛒.🚩showADSheet) {
                📣ADView(self.ⓐpp, second: 10)
                    .environmentObject(🛒)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    🛒.checkToShowADSheet()
                }
            }
    }
}

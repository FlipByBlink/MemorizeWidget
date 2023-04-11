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
                switch 📱.🪧widgetState.info {
                    case .singleNote(let ⓘd):
                        self.ⓢigleNoteLayout(ⓘd)
                    case .multiNotes(let ⓘds):
                        if ⓘds.count == 1 {
                            self.ⓢigleNoteLayout(ⓘds[0])
                        } else {
                            self.ⓜultiNotesLayout(ⓘds)
                        }
                    default:
                        Text("🐛")
                }
            }
            .toolbar { 🅧DismissButton() }
        }
        .modifier(📣ADSheet())
        .navigationViewStyle(.stack)
    }
    private func ⓢigleNoteLayout(_ ⓘd: UUID) -> some View {
        VStack {
            Spacer()
            if let ⓘndex = 📱.📚notes.firstIndex(where: { $0.id == ⓘd }) {
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
            }
            Spacer()
        }
    }
    private func ⓜultiNotesLayout(_ ⓘds: [UUID]) -> some View {
        List {
            ForEach(ⓘds, id: \.self) {
                self.ⓝoteRow($0)
            }
        }
    }
    private func ⓝoteRow(_ ⓘd: UUID) -> some View {
        Section {
            if let ⓘndex = 📱.📚notes.firstIndex(where: { $0.id == ⓘd }) {
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
            if !📱.📚notes.contains(where: { $0.id == ⓘd }) { //Workaround: iOS15.5
                🚮DeletedNoteView()
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
        VStack(spacing: 0) {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("placeholder")
                        .font(.title.weight(.semibold))
                        .padding(.bottom, 1)
                    Text("placeholder")
                        .font(.title3.weight(.light))
                        .padding(.bottom, 1)
                }
                Spacer()
            }
            .padding(.leading, 12)
            .padding(.vertical, 12)
            Image(systemName: "trash")
                .font(.title3)
                .padding(12)
        }
        .padding(8)
        .opacity(0)
        .overlay {
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
        }
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

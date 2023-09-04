import SwiftUI

struct 📖WidgetNotesSheet: ViewModifier {
    @EnvironmentObject var 📱: 📱AppModel
    @EnvironmentObject var 🛒: 🛒InAppPurchaseModel
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
            .navigationBarTitleDisplayMode(.inline)
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
        @Environment(\.horizontalSizeClass) var horizontalSizeClass
        private var ⓘds: [UUID] { 📱.🪧widgetState.info?.targetedNoteIDs ?? [] }
        private var ⓣargetNotesCount: Int { 📱.🪧widgetState.info?.targetedNotesCount ?? 0 }
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
                if 📱.deletedAllWidgetNotes {
                    Section { 🚮DeletedNoteView() }
                }
            }
        }
        private func ⓝoteRow(_ ⓘd: UUID) -> some View {
            Group {
                if let ⓘndex = 📱.📚notes.index(ⓘd) {
                    if self.horizontalSizeClass == .compact {
                        VStack(spacing: 0) {
                            📓NoteView($📱.📚notes[ⓘndex],
                                       layout: .widgetSheet_multi(self.ⓣargetNotesCount))
                            HStack {
                                Spacer()
                                📘DictionaryButton(📱.📚notes[ⓘndex])
                                Spacer()
                                🔍SearchButton(📱.📚notes[ⓘndex])
                                Spacer()
                                if !📱.🚩randomMode {
                                    🔚MoveEndButton(📱.📚notes[ⓘndex])
                                    Spacer()
                                }
                                🚮DeleteNoteButton(📱.📚notes[ⓘndex])
                                Spacer()
                            }
                            .labelStyle(.iconOnly)
                            .buttonStyle(.plain)
                            .foregroundColor(.primary)
                            .font(self.ⓣargetNotesCount < 4 ? .title3 : .body)
                            .padding(self.ⓣargetNotesCount < 4 ? 12 : 4)
                        }
                        .padding(self.ⓣargetNotesCount < 4 ? 8 : 4)
                    } else {
                        HStack(spacing: 0) {
                            📓NoteView($📱.📚notes[ⓘndex],
                                       layout: .widgetSheet_multi(self.ⓣargetNotesCount))
                            HStack(spacing: 24) {
                                📘DictionaryButton(📱.📚notes[ⓘndex])
                                🔍SearchButton(📱.📚notes[ⓘndex])
                                if !📱.🚩randomMode { 🔚MoveEndButton(📱.📚notes[ⓘndex]) }
                                🚮DeleteNoteButton(📱.📚notes[ⓘndex])
                            }
                            .labelStyle(.iconOnly)
                            .buttonStyle(.plain)
                            .foregroundColor(.primary)
                            .padding()
                            .font(self.ⓣargetNotesCount < 4 ? .title3 : .body)
                        }
                        .padding(self.ⓣargetNotesCount < 4 ? 8 : 0)
                    }
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

private struct 🔚MoveEndButton: View {
    @EnvironmentObject var 📱: 📱AppModel
    private var ⓝote: 📗Note
    @State private var ⓓone: Bool = false
    var body: some View {
        Button {
            📱.moveEnd(self.ⓝote)
            withAnimation { self.ⓓone = true }
        } label: {
            Label("Move end", systemImage: "arrow.down.to.line")
        }
        .disabled(📱.📚notes.last == self.ⓝote)
        .opacity(self.ⓓone ? 0.33 : 1)
        .overlay {
            if self.ⓓone {
                Image(systemName: "checkmark")
                    .imageScale(.small)
                    .symbolRenderingMode(.hierarchical)
            }
        }
    }
    init(_ note: 📗Note) {
        self.ⓝote = note
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
    @EnvironmentObject var 🛒: 🛒InAppPurchaseModel
    @State private var ⓐpp: 📣ADTargetApp = .pickUpAppWithout(.MemorizeWidget)
    @State private var showSheet: Bool = false
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: self.$showSheet) {
                📣ADView(self.ⓐpp, second: 10)
                    .environmentObject(🛒)
            }
            .task {
                try? await Task.sleep(for: .seconds(1))
                if 🛒.checkToShowADSheet() {
                    self.showSheet = true
                }
            }
    }
}

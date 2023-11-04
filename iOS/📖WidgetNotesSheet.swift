import SwiftUI

struct 📖WidgetNotesSheet: ViewModifier {
    @EnvironmentObject var appModel: 📱AppModel
    @EnvironmentObject var inAppPurchaseModel: 🛒InAppPurchaseModel
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: self.$appModel.widgetState.showSheet) {
                📖WidgetNotesView()
                    .environmentObject(self.appModel)
                    .environmentObject(self.inAppPurchaseModel)
            }
    }
}

private struct 📖WidgetNotesView: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        NavigationStack {
            Group {
                if self.model.widgetState.info?.targetedNotesCount == 1 {
                    Self.SigleNoteLayoutView()
                } else {
                    Self.MultiNotesLayoutView()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { 🅧DismissButton() }
        }
        .modifier(📣ADSheet())
    }
    private struct SigleNoteLayoutView: View {
        @EnvironmentObject var model: 📱AppModel
        private var ⓘndex: Int? {
            self.model.notes.index(self.model.widgetState.info?.targetedNoteIDs?.first)
        }
        var body: some View {
            VStack {
                Spacer()
                if let ⓘndex {
                    📗NoteView(self.$model.notes[ⓘndex], layout: .widgetSheet_single)
                        .padding(.horizontal, 32)
                    Spacer()
                    HStack {
                        Spacer()
                        📘DictionaryButton(self.model.notes[ⓘndex])
                        Spacer()
                        🔍SearchButton(self.model.notes[ⓘndex])
                        Spacer()
                        🚮DeleteNoteButton(self.model.notes[ⓘndex])
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
    private struct MultiNotesLayoutView: View {
        @EnvironmentObject var model: 📱AppModel
        @Environment(\.horizontalSizeClass) var horizontalSizeClass
        private var ids: [UUID] { self.model.widgetState.info?.targetedNoteIDs ?? [] }
        private var targetNotesCount: Int { self.model.widgetState.info?.targetedNotesCount ?? 0 }
        var body: some View {
            List {
                if self.targetNotesCount < 4 {
                    ForEach(self.ids, id: \.self) { ⓘd in
                        Section { self.noteRow(ⓘd) }
                    }
                } else {
                    Section {
                        ForEach(self.ids, id: \.self) { self.noteRow($0) }
                    }
                }
                if self.model.deletedAllWidgetNotes {
                    Section { 🚮DeletedNoteView() }
                }
            }
        }
        private func noteRow(_ ⓘd: UUID) -> some View {
            Group {
                if let ⓘndex = self.model.notes.index(ⓘd) {
                    if self.horizontalSizeClass == .compact {
                        VStack(spacing: 0) {
                            📗NoteView(self.$model.notes[ⓘndex],
                                       layout: .widgetSheet_multi(self.targetNotesCount))
                            HStack {
                                Spacer()
                                📘DictionaryButton(self.model.notes[ⓘndex])
                                Spacer()
                                🔍SearchButton(self.model.notes[ⓘndex])
                                Spacer()
                                if !self.model.randomMode {
                                    🔚MoveEndButton(self.model.notes[ⓘndex])
                                    Spacer()
                                }
                                🚮DeleteNoteButton(self.model.notes[ⓘndex])
                                Spacer()
                            }
                            .labelStyle(.iconOnly)
                            .buttonStyle(.plain)
                            .foregroundColor(.primary)
                            .font(self.targetNotesCount < 4 ? .title3 : .body)
                            .padding(self.targetNotesCount < 4 ? 12 : 4)
                        }
                        .padding(self.targetNotesCount < 4 ? 8 : 4)
                    } else {
                        HStack(spacing: 0) {
                            📗NoteView(self.$model.notes[ⓘndex],
                                       layout: .widgetSheet_multi(self.targetNotesCount))
                            HStack(spacing: 24) {
                                📘DictionaryButton(self.model.notes[ⓘndex])
                                🔍SearchButton(self.model.notes[ⓘndex])
                                if !self.model.randomMode { 🔚MoveEndButton(self.model.notes[ⓘndex]) }
                                🚮DeleteNoteButton(self.model.notes[ⓘndex])
                            }
                            .labelStyle(.iconOnly)
                            .buttonStyle(.plain)
                            .foregroundColor(.primary)
                            .padding()
                            .font(self.targetNotesCount < 4 ? .title3 : .body)
                        }
                        .padding(self.targetNotesCount < 4 ? 8 : 0)
                    }
                }
            }
        }
    }
}

private struct 📘DictionaryButton: View {
    private var term: String
    @State private var dictionaryState: 📘DictionaryState = .default
    var body: some View {
#if !targetEnvironment(macCatalyst)
        Button {
            self.dictionaryState.request(self.term)
        } label: {
            Label("Dictionary", systemImage: "character.book.closed")
        }
        .modifier(📘DictionarySheet(self.$dictionaryState))
#else
        📘DictionaryButtonOnMac(term: self.term)
#endif
    }
    init(_ note: 📗Note) {
        self.term = note.title
    }
}

private struct 🔚MoveEndButton: View {
    @EnvironmentObject var model: 📱AppModel
    private var note: 📗Note
    @State private var done: Bool = false
    var body: some View {
        Button {
            self.model.moveEnd(self.note)
            withAnimation { self.done = true }
        } label: {
            Label("Move end", systemImage: "arrow.down.to.line")
        }
        .disabled(self.model.notes.last == self.note)
        .opacity(self.done ? 0.33 : 1)
        .overlay {
            if self.done {
                Image(systemName: "checkmark")
                    .imageScale(.small)
                    .symbolRenderingMode(.hierarchical)
            }
        }
    }
    init(_ note: 📗Note) {
        self.note = note
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
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        Button {
            self.model.widgetState.showSheet = false
            UISelectionFeedbackGenerator().selectionChanged()
        } label: {
            Image(systemName: "xmark.circle.fill")
                .symbolRenderingMode(.hierarchical)
        }
        .foregroundColor(.secondary)
        .keyboardShortcut(.cancelAction)
    }
}

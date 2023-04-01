import SwiftUI

struct 📓NoteRowOnListTab: View {
    @EnvironmentObject var 📱: 📱AppModel
    @Binding private var ⓝote: 📗Note
    @State private var 🔍preferredFocus: 🄵ocusArea? = nil
    private var 🎨thin: Bool { !📱.🚩randomMode && (📱.📚notes.first != self.ⓝote) }
    private var 🚩userInputting: Bool { self.🔍preferredFocus != nil }
    var body: some View {
        HStack {
            if self.🚩userInputting {
                📝InputNoteView(self.$🔍preferredFocus, self.$ⓝote)
            } else {
                self.ⓢtaticNoteView()
            }
            🎛️NoteMenuButton(self.$ⓝote, self.$🔍preferredFocus)
        }
        .onAppear { self.ⓢetFocusForEmptyNote() }
        .animation(.default, value: self.🚩userInputting)
    }
    private func ⓢtaticNoteView() -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(self.ⓝote.title.isEmpty ? "no title" : self.ⓝote.title)
                    .font(.title2.weight(.semibold))
                    .foregroundStyle(self.🎨thin ? .tertiary : .primary)
                    .opacity(self.ⓝote.title.isEmpty ? 0.25 : 1)
                Text(self.ⓝote.comment.isEmpty ? "no comment" : self.ⓝote.comment)
                    .font(.title3.weight(.light))
                    .foregroundStyle(self.🎨thin ? .tertiary : .secondary)
                    .opacity(self.ⓝote.comment.isEmpty ? 0.5 : 0.8)
            }
            .padding(8)
            .padding(.vertical, 6)
            Spacer()
        }
    }
    private func ⓢetFocusForEmptyNote() {
        if self.ⓝote.isEmpty { self.🔍preferredFocus = .title }
    }
    init(_ note: Binding<📗Note>) {
        self._ⓝote = note
    }
}

struct 📓NoteRowOnPickedNotesSheet: View {
    @EnvironmentObject var 📱: 📱AppModel
    @Binding private var ⓝote: 📗Note
    @State private var 🔍preferredFocus: 🄵ocusArea? = nil
    private var 🚩userInputting: Bool { self.🔍preferredFocus != nil }
    var body: some View {
        VStack(spacing: 16) {
            if self.🚩userInputting {
                📝InputNoteView(self.$🔍preferredFocus, self.$ⓝote)
            } else {
                self.ⓢtaticNoteView()
            }
            HStack {
                Spacer()
                Button {
                    self.🔍preferredFocus = .title
                } label: {
                    Label("Edit note", systemImage: "rectangle.and.pencil.and.ellipsis")
                }
                Spacer()
                📗DictionaryButtonOnNotesSheet(self.ⓝote)
                Spacer()
                🔍SearchButton(self.ⓝote)
                Spacer()
                Button(role: .destructive) {
                    withAnimation {
                        📱.📚notes.removeAll { $0 == self.ⓝote }
                    }
                } label: {
                    Label("Delete", systemImage: "trash")
                }
                Spacer()
            }
            .labelStyle(.iconOnly)
            .buttonStyle(.plain)
        }
        .padding(.vertical, 24)
        .animation(.default, value: self.🚩userInputting)
    }
    private func ⓢtaticNoteView() -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(self.ⓝote.title.isEmpty ? "no title" : self.ⓝote.title)
                    .font(.title2.weight(.semibold))
                    .foregroundStyle(.primary)
                    .opacity(self.ⓝote.title.isEmpty ? 0.25 : 1)
                Text(self.ⓝote.comment.isEmpty ? "no comment" : self.ⓝote.comment)
                    .font(.title3.weight(.light))
                    .foregroundStyle(.secondary)
                    .opacity(self.ⓝote.comment.isEmpty ? 0.5 : 0.8)
            }
            .padding(8)
            .padding(.vertical, 6)
            Spacer()
        }
    }
    init(_ note: Binding<📗Note>) {
        self._ⓝote = note
    }
}

struct 📝InputNoteView: View {
    @EnvironmentObject var 📱: 📱AppModel
    @Binding var 🔍preferredFocus: 🄵ocusArea?
    @Binding var ⓝote: 📗Note
    @FocusState private var 🔍focusState: 🄵ocusArea?
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            TextField("+ title", text: self.$ⓝote.title)
                .focused(self.$🔍focusState, equals: .title)
                .font(.title2.weight(.semibold))
            TextField("+ comment", text: self.$ⓝote.comment)
                .focused(self.$🔍focusState, equals: .comment)
                .font(.title3.weight(.medium))
                .foregroundStyle(.secondary)
                .opacity(0.8)
        }
        .onChange(of: self.🔍focusState) { self.ⓗandleFocusState($0) }
        .onSubmit { UISelectionFeedbackGenerator().selectionChanged() }
        .padding(8)
        .padding(.vertical, 6)
        .onAppear { self.ⓗandlePreferredFocus() }
    }
    private func ⓗandleFocusState(_ ⓕocusState: 🄵ocusArea?) {
        if ⓕocusState == nil {
            self.🔍preferredFocus = nil
            if self.ⓝote.isEmpty {
                self.📱.📚notes.removeAll { $0 == self.ⓝote }
            }
        }
    }
    private func ⓗandlePreferredFocus() {
        if let 🔍preferredFocus {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.🔍focusState = 🔍preferredFocus
            }
        }
    }
    init(_ 🔍preferredFocus: Binding<🄵ocusArea?>, _ ⓝote: Binding<📗Note>) {
        self._🔍preferredFocus = 🔍preferredFocus
        self._ⓝote = ⓝote
    }
}

enum 🄵ocusArea {
    case title, comment
}

struct 🎛️NoteMenuButton: View { //MARK: Work in progress
    @EnvironmentObject var 📱: 📱AppModel
    @Binding var ⓝote: 📗Note
    @Binding var ⓟreferredFocus: 🄵ocusArea?
    @State private var 🚩showDictionarySheet: Bool = false
    private var ⓝoteIndex: Int? { 📱.📚notes.firstIndex(of: self.ⓝote) }
    var body: some View {
        Menu {
            if let ⓝoteIndex {
                Section {
                    Button {
                        self.ⓟreferredFocus = .title
                    } label: {
                        Label("Edit title", systemImage: "pencil")
                    }
                    Button {
                        self.ⓟreferredFocus = .comment
                    } label: {
                        Label("Edit comment", systemImage: "pencil")
                    }
                }
                📗DictionaryButton(self.$🚩showDictionarySheet)
                🔍SearchButton(ⓝote)
                Button {
                    📱.addNewNote(ⓝoteIndex + 1)
                } label: {
                    Label("New note", systemImage: "text.append")
                }
                Section {
                    Button {
                    } label: {
                        Label("Move top", systemImage: "arrow.up.to.line")
                    }
                    Button {
                    } label: {
                        Label("Move end", systemImage: "arrow.down.to.line")
                    }
                }
                Section {
                    Button(role: .destructive) {
                        📱.📚notes.remove(at: ⓝoteIndex)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
            } else {
                Text("🐛")
            }
        } label: {
            Label("Menu", systemImage: "ellipsis.circle")
                .labelStyle(.iconOnly)
                .padding(.vertical, 8)
                .padding(.trailing, 8)
        }
        .foregroundStyle(.secondary)
        .modifier(📗DictionarySheet(self.ⓝote, self.$🚩showDictionarySheet))
        .modifier(🩹Workaround.closeMenePopup())
    }
    init(_ note: Binding<📗Note>, _ preferredFocus: Binding<🄵ocusArea?>) {
        self._ⓝote = note
        self._ⓟreferredFocus = preferredFocus
    }
}

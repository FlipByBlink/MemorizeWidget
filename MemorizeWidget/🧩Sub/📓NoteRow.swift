import SwiftUI

struct 📓NoteRow: View { //MARK: Work in progress
    @EnvironmentObject var 📱: 📱AppModel
    @Binding private var ⓝote: 📗Note
    @State private var 🚩inputting: Bool = false
    @FocusState private var 🔍focusState: 🄵ocusArea?
    private var 🎨thin: Bool { !📱.🚩randomMode && (📱.📚notes.first != self.ⓝote) }
    var body: some View {
        VStack(spacing: 12) {
            if self.🚩inputting {
                self.ⓘnputNoteView()
            } else {
                self.ⓢtaticNoteView()
            }
            self.ⓑuttons()
        }
        .padding(8)
        .onChange(of: self.🔍focusState) { self.ⓗandleUnfocus($0) }
        .onAppear { self.ⓢetFocusForEmptyNote() }
        .animation(.default, value: self.🚩inputting)
    }
    private func ⓘnputNoteView() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            TextField("+ title", text: self.$ⓝote.title)
                .focused(self.$🔍focusState, equals: .title)
                .font(.title2.weight(.semibold))
            TextField("+ comment", text: self.$ⓝote.comment)
                .focused(self.$🔍focusState, equals: .comment)
                .font(.title3.weight(.light))
                .foregroundStyle(.secondary)
                .opacity(0.8)
        }
        .onSubmit { UISelectionFeedbackGenerator().selectionChanged() }
    }
    private func ⓢtaticNoteView() -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(self.ⓝote.title.isEmpty ? "no title" : self.ⓝote.title)
                    .font(.title2.weight(.semibold))
                    .foregroundStyle(.primary)
                    .opacity(self.ⓝote.title.isEmpty ? 0.25 : 1)
                    .padding(.bottom, 1)
                    .onTapGesture { self.ⓢtartToInput(.title) }
                Text(self.ⓝote.comment.isEmpty ? "no comment" : self.ⓝote.comment)
                    .font(.title3.weight(.light))
                    .foregroundStyle(.secondary)
                    .opacity(self.ⓝote.comment.isEmpty ? 0.5 : 0.8)
                    .padding(.bottom, 1)
                    .onTapGesture { self.ⓢtartToInput(.comment) }
            }
            Spacer()
        }
    }
    private func ⓑuttons() -> some View {
        HStack {
            Spacer()
            Button {
                self.ⓢtartToInput(.title)
            } label: {
                Label("Edit note", systemImage: "rectangle.and.pencil.and.ellipsis")
            }
            Spacer()
            📗DictionaryButtonOnNotesSheet(self.ⓝote)
            Spacer()
            🔍SearchButton(self.ⓝote)
            Spacer()
            Menu {
                Button(role: .destructive) {
                    withAnimation {
                        📱.📚notes.removeAll { $0 == self.ⓝote }
                    }
                } label: {
                    Label("Delete", systemImage: "trash")
                }
            } label: {
                Label("Delete", systemImage: "trash")
            }
            Spacer()
        }
        .labelStyle(.iconOnly)
        .buttonStyle(.plain)
        .foregroundStyle(.secondary)
        .imageScale(.small)
    }
    private func ⓢtartToInput(_ ⓐrea: 🄵ocusArea) {
        withAnimation { self.🚩inputting = true }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
            withAnimation { self.🔍focusState = ⓐrea }
        }
    }
    private func ⓗandleUnfocus(_ ⓕocus: 🄵ocusArea?) {
        if ⓕocus == nil {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation { self.🚩inputting = false }
                if self.ⓝote.isEmpty {
                    self.📱.📚notes.removeAll { $0 == self.ⓝote }
                }
            }
        }
    }
    private func ⓢetFocusForEmptyNote() {
        if self.ⓝote.isEmpty {
            self.ⓢtartToInput(.title)
        }
    }
    init(_ note: Binding<📗Note>) {
        self._ⓝote = note
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

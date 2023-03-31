import SwiftUI

struct 📓NoteRow: View {
    @EnvironmentObject var 📱: 📱AppModel
    @Environment(\.scenePhase) var scenePhase
    @AppStorage("RandomMode", store: .ⓐppGroup) var 🚩randomMode: Bool = false
    @State private var 🔍preferredFocus: 🄵ocusArea? = nil
    @FocusState private var 🔍focusState: 🄵ocusArea?
    @Binding private var ⓝote: 📗Note
    private var 🎨thin: Bool { !self.🚩randomMode && (📱.📚notes.first != self.ⓝote) }
    private var 🚩focusDisable: Bool {
        📱.🚩showNotesImportSheet || 📱.🚩showNoteSheet || (self.scenePhase != .active)
    }
    private var 🚩userInputting: Bool { self.🔍preferredFocus != nil }
    var body: some View {
        HStack {
            if self.🚩userInputting {
                VStack(alignment: .leading, spacing: 8) {
                    TextField("+ title", text: self.$ⓝote.title)
                        .focused(self.$🔍focusState, equals: .title)
                        .font(.title2.weight(.semibold))
                        .foregroundStyle(self.🎨thin ? .tertiary : .primary)
                    TextField("+ comment", text: self.$ⓝote.comment)
                        .focused(self.$🔍focusState, equals: .comment)
                        .font(.title3.weight(.medium))
                        .foregroundStyle(self.🎨thin ? .tertiary : .secondary)
                        .opacity(0.8)
                }
                .onChange(of: self.🔍focusState) { self.ⓗandleFocusState($0) }
                .onSubmit { UISelectionFeedbackGenerator().selectionChanged() }
                .padding(8)
                .padding(.vertical, 6)
            } else {
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
            🎛️NoteMenuButton(self.$ⓝote, self.$🔍preferredFocus)
                .onChange(of: self.🔍preferredFocus) { self.ⓗandlePreferredFocus($0) }
        }
        .onAppear { self.ⓢetFocusForEmptyNote() }
        .animation(.default, value: self.🚩userInputting)
        .onChange(of: self.🚩focusDisable) {
            if $0 { self.🔍focusState = nil }
        }
    }
    private func ⓗandleFocusState(_ ⓕocusState: 🄵ocusArea?) {
        if ⓕocusState == nil {
            self.🔍preferredFocus = nil
            if self.ⓝote.isEmpty {
                self.📱.📚notes.removeAll { $0 == self.ⓝote }
            }
        }
    }
    private func ⓗandlePreferredFocus(_ ⓟreferredFocus: 🄵ocusArea?) {
        if let ⓟreferredFocus {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.🔍focusState = ⓟreferredFocus
            }
        }
    }
    private func ⓢetFocusForEmptyNote() {
        if self.ⓝote.isEmpty { self.🔍preferredFocus = .title }
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
                📗SystemDictionaryButton(ⓝoteIndex)
                🔍SearchButton(ⓝoteIndex)
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
    }
    init(_ note: Binding<📗Note>, _ preferredFocus: Binding<🄵ocusArea?>) {
        self._ⓝote = note
        self._ⓟreferredFocus = preferredFocus
    }
}

import SwiftUI
import WidgetKit

struct 📚NotesListTab: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        NavigationView {
            ScrollViewReader { 🚡 in
                List {
                    🚩RandomModeSection()
                    Section {
                        🆕NewNoteButton()
                            .id("NewNoteButton")
                            .onOpenURL {
                                if $0.description == "NewNoteShortcut" {
                                    🚡.scrollTo("NewNoteButton")
                                }
                            }
                        ForEach($📱.📚notes) { 📓NoteRow($0) }
                            .onDelete { 📱.📚notes.remove(atOffsets: $0) }
                            .onMove { 📱.📚notes.move(fromOffsets: $0, toOffset: $1) }
                    } footer: {
                        Text("Notes count: \(📱.📚notes.count.description)")
                            .opacity(📱.📚notes.count < 6  ? 0 : 1)
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .animation(.default, value: 📱.📚notes)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                            .disabled(📱.📚notes.isEmpty)
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            UISelectionFeedbackGenerator().selectionChanged()
                            📱.🚩showNotesImportSheet.toggle()
                        } label: {
                            Label("Import notes", systemImage: "tray.and.arrow.down")
                        }
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}

private struct 🚩RandomModeSection: View {
    @AppStorage("RandomMode", store: .ⓐppGroup) var ⓥalue: Bool = false
    var body: some View {
        Section {
            Toggle(isOn: self.$ⓥalue) {
                Label("Random mode", systemImage: "shuffle")
                    .padding(.vertical, 8)
            }
            .onChange(of: self.ⓥalue) { _ in
                WidgetCenter.shared.reloadAllTimelines()
            }
        } footer: {
            Text("Change the note per 5 minutes.")
        }
    }
}

private struct 🆕NewNoteButton: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        Button {
            📱.addNewNote()
        } label: {
            Label("New note", systemImage: "plus")
                .font(.title3.weight(.semibold))
                .padding(.vertical, 7)
        }
        .disabled(📱.📚notes.first?.title == "")
    }
}

private struct 📓NoteRow: View {
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
    private var ⓘnputting: Bool {
        self.ⓝote.isEmpty || (self.🔍preferredFocus != nil)
    }
    var body: some View {
        HStack {
            if self.ⓘnputting {
                VStack(alignment: .leading, spacing: 8) {
                    TextField("+ title", text: self.$ⓝote.title)
                        .focused(self.$🔍focusState, equals: .title)
                        .font(.title2.weight(.semibold))
                        .foregroundStyle(self.🎨thin ? .tertiary : .primary)
                    TextField("+ comment", text: self.$ⓝote.comment)
                        .focused(self.$🔍focusState, equals: .comment)
                        .font(.title3.weight(.light))
                        .foregroundStyle(self.🎨thin ? .tertiary : .secondary)
                        .opacity(0.8)
                }
                .onAppear {
                    if self.ⓝote.isEmpty { self.🔍preferredFocus = .title }
                }
                .onChange(of: self.🔍focusState) {
                    if $0 == nil {
                        self.🔍preferredFocus = nil
                        if self.ⓝote.isEmpty {
                            self.📱.📚notes.removeAll { $0 == self.ⓝote }
                        }
                    }
                }
                .onSubmit { UISelectionFeedbackGenerator().selectionChanged() }
                .padding(8)
                .padding(.vertical, 6)
                .accessibilityHidden(!self.ⓝote.title.isEmpty)
            } else {
                VStack(alignment: .leading, spacing: 8) {
                    Text(self.ⓝote.title.isEmpty ? "no title" : self.ⓝote.title)
                        .font(.title2.weight(.semibold))
                        .foregroundStyle(self.🎨thin ? .tertiary : .primary)
                        .opacity(self.ⓝote.title.isEmpty ? 0.25 : 1)
                    Text(self.ⓝote.comment.isEmpty ? "no comment" : self.ⓝote.comment)
                        .font(.title3.weight(.light))
                        .foregroundStyle(self.🎨thin ? .tertiary : .secondary)
                        .opacity(0.8)
                }
                .padding(8)
                .padding(.vertical, 6)
                Spacer()
            }
            🎛️NoteMenuButton(self.$ⓝote, self.$🔍preferredFocus)
                .onChange(of: self.🔍preferredFocus) {
                    if let ⓟreferredFocus = $0 {
                        self.🔍focusState = ⓟreferredFocus
                    }
                }
        }
        .animation(.default, value: self.ⓘnputting)
        .onChange(of: self.🚩focusDisable) {
            if $0 { self.🔍focusState = nil }
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

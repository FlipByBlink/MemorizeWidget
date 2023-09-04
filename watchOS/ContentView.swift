import SwiftUI
import WidgetKit

struct ContentView: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        NavigationStack {
            List {
                NavigationLink {
                    📚NotesMenu()
                } label: {
                    LabeledContent {
                        Text(📱.📚notes.count.description)
                    } label: {
                        Label("Notes", systemImage: "books.vertical")
                    }
                }
                NavigationLink {
                    🔩MainMenu()
                } label: {
                    Label("Menu", systemImage: "gearshape")
                }
                NavigationLink {
                    💁TipsMenu()
                } label: {
                    Label("Tips", systemImage: "star.bubble")
                }
                NavigationLink {
                    ℹ️AboutAppMenu()
                } label: {
                    Label("About App", systemImage: "questionmark")
                }
            }
            .navigationTitle("MemorizeWidget")
        }
        .modifier(🆕NewNoteShortcut())
        .onOpenURL(perform: 📱.handleWidgetURL)
        .sheet(isPresented: $📱.🪧widgetState.showSheet) { 📖WidgetNotesSheet() }
    }
}

private struct 📚NotesMenu: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        List {
            TextFieldLink {
                Label("New note", systemImage: "plus")
            } onSubmit: {
                📱.insertOnTop([📗Note($0)])
            }
            ForEach($📱.📚notes) { ⓝote in
                NavigationLink {
                    📗NoteView(ⓝote, .notesMenu)
                } label: {
                    Self.🄽oteLink(note: ⓝote)
                }
            }
            .onDelete {
                📱.deleteNote($0)
                💥Feedback.warning()
            }
            .onMove {
                📱.moveNote($0, $1)
                💥Feedback.light()
            }
        }
        .animation(.default, value: 📱.📚notes)
        .navigationTitle("Notes")
    }
    private struct 🄽oteLink: View {
        @EnvironmentObject var 📱: 📱AppModel
        @Binding var note: 📗Note
        private var ⓘnactive: Bool {
            !📱.🚩randomMode
            && 📱.📚notes.first != self.note
        }
        var body: some View {
            VStack(alignment: .leading) {
                Text(self.note.title)
                    .font(.headline)
                    .foregroundStyle(self.ⓘnactive ? .secondary : .primary)
                Text(self.note.comment)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

private struct 📗NoteView: View {
    @EnvironmentObject var 📱: 📱AppModel
    @Environment(\.dismiss) var dismiss
    @Binding var ⓝote: 📗Note
    private var ⓚind: Self.🄺ind = .notesMenu
    var body: some View {
        List {
            TextField("Title", text: self.$ⓝote.title)
                .font(.headline)
            TextField("Comment", text: self.$ⓝote.comment)
                .font(.caption)
                .foregroundStyle(.secondary)
            switch self.ⓚind {
                case .notesMenu:
                    self.ⓜoveSectionOnNotesMenu()
                    self.ⓡemoveButton()
                case .notesSheet:
                    if 📱.🚩randomMode {
                        self.ⓡemoveButton()
                    } else {
                        self.ⓜoveEndButtonOnNotesSheet()
                        self.ⓡemoveButton()
                    }
            }
        }
    }
    private func ⓡemoveButton() -> some View {
        Button(role: .destructive) {
            📱.removeNote(self.ⓝote)
            self.dismiss()
        } label: {
            Label("Delete", systemImage: "trash")
        }
    }
    private func ⓜoveSectionOnNotesMenu() -> some View {
        HStack {
            Button {
                📱.moveTop(self.ⓝote)
                self.dismiss()
            } label: {
                Label("Move top", systemImage: "arrow.up.to.line.circle.fill")
                    .labelStyle(.iconOnly)
                    .symbolRenderingMode(.hierarchical)
                    .font(.title2)
            }
            .buttonStyle(.plain)
            .disabled(self.ⓝote.id == 📱.📚notes.first?.id)
            Spacer()
            Text("Move")
                .font(.headline)
                .foregroundStyle(📱.📚notes.count <= 1 ? .tertiary : .primary)
            Spacer()
            Button {
                📱.moveEnd(self.ⓝote)
                self.dismiss()
            } label: {
                Label("Move end", systemImage: "arrow.down.to.line.circle.fill")
                    .labelStyle(.iconOnly)
                    .symbolRenderingMode(.hierarchical)
                    .font(.title2)
            }
            .buttonStyle(.plain)
            .disabled(self.ⓝote.id == 📱.📚notes.last?.id)
        }
    }
    private func ⓜoveEndButtonOnNotesSheet() -> some View {
        Button {
            📱.moveEnd(self.ⓝote)
        } label: {
            Label("Move end", systemImage: "arrow.down.to.line")
        }
        .disabled(self.ⓝote.id == 📱.📚notes.last?.id)
    }
    enum 🄺ind {
        case notesMenu, notesSheet
    }
    init(_ note: Binding<📗Note>, _ kind: Self.🄺ind) {
        self._ⓝote = note
        self.ⓚind = kind
    }
}

private struct 📖WidgetNotesSheet: View {
    @EnvironmentObject var 📱: 📱AppModel
    private var ⓘds: [UUID] { 📱.🪧widgetState.info?.targetedNoteIDs ?? [] }
    var body: some View {
        NavigationStack {
            List {
                ForEach(self.ⓘds, id: \.self) {
                    Self.🄽oteView(id: $0)
                }
                .onDelete {
                    guard let ⓘndex = $0.first else { return }
                    📱.removeNote(self.ⓘds[ⓘndex])
                }
            }
            .overlay {
                if 📱.deletedAllWidgetNotes { Self.🄳eletedNoteView() }
            }
        }
    }
    private struct 🄽oteView: View {
        @EnvironmentObject var 📱: 📱AppModel
        var id: UUID
        private var ⓝoteIndex: Int? { 📱.📚notes.index(self.id) }
        private var ⓞneNoteLayout: Bool { 📱.🪧widgetState.info?.targetedNotesCount == 1 }
        var body: some View {
            if let ⓝoteIndex {
                NavigationLink {
                    📗NoteView($📱.📚notes[ⓝoteIndex], .notesSheet)
                } label: {
                    VStack(alignment: .leading) {
                        Text(📱.📚notes[ⓝoteIndex].title)
                            .font(self.ⓞneNoteLayout ? .title2 : .title3)
                            .bold()
                        Text(📱.📚notes[ⓝoteIndex].comment)
                            .font(self.ⓞneNoteLayout ? .body : .subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.vertical, self.ⓞneNoteLayout ? 12 : 8)
            }
        }
    }
    private struct 🄳eletedNoteView: View {
        var body: some View {
            VStack(spacing: 16) {
                Label("Deleted.", systemImage: "checkmark")
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                Image(systemName: "trash")
            }
            .foregroundColor(.primary)
            .imageScale(.small)
            .font(.title2)
            .padding(24)
        }
    }
}

private struct 🆕NewNoteShortcut: ViewModifier {
    @EnvironmentObject var 📱: 📱AppModel
    @State private var 🚩showSheet: Bool = false
    @FocusState private var 🚩focus: Bool
    @State private var ⓣitle: String = ""
    @State private var ⓒomment: String = ""
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: self.$🚩showSheet) {
                List {
                    TextField("Title", text: self.$ⓣitle)
                        .font(.headline)
                    TextField("Comment", text: self.$ⓒomment)
                        .font(.subheadline)
                        .opacity(self.ⓣitle.isEmpty ? 0.33 : 1)
                    Section {
                        Button {
                            📱.insertOnTop([📗Note(self.ⓣitle, self.ⓒomment)])
                            self.🚩showSheet = false
                            💥Feedback.success()
                            Task { @MainActor in
                                try? await Task.sleep(for: .seconds(1))
                                self.ⓣitle = ""
                                self.ⓒomment = ""
                            }
                        } label: {
                            Label("Done", systemImage: "checkmark")
                        }
                        .buttonStyle(.bordered)
                        .listRowBackground(Color.clear)
                        .fontWeight(.semibold)
                        .disabled(self.ⓣitle.isEmpty)
                        .foregroundStyle(self.ⓣitle.isEmpty ? .tertiary : .primary)
                    }
                }
                .animation(.default, value: self.ⓣitle.isEmpty)
            }
            .onOpenURL(perform: self.ⓗandleNewNoteShortcut(_:))
    }
    private func ⓗandleNewNoteShortcut(_ ⓤrl: URL) {
        if case .newNoteShortcut = 🪧WidgetInfo.load(ⓤrl) {
            self.🚩showSheet = true
        }
    }
}

import SwiftUI
import WidgetKit

struct ContentView_WatchOSApp: View {
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
                    🔩Menu()
                } label: {
                    Label("Menu", systemImage: "gearshape")
                }
            }
            .navigationTitle("MemorizeWidget")
        }
        .onOpenURL(perform: 📱.handleWidgetURL)
        .onOpenURL(perform: self.ⓗandleNewNoteShortcut(_:))
        .sheet(isPresented: $📱.🪧widgetState.showSheet) { 📖WidgetNotesSheet() }
    }
    private func ⓗandleNewNoteShortcut(_ ⓤrl: URL) {
        if case .newNoteShortcut = 🪧WidgetInfo.load(ⓤrl) {
            //📱.addNewNoteOnTop()
            print("🖨️", #function)
        }
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
                    📗NoteView(ⓝote)
                } label: {
                    Self.🄽oteLink(note: ⓝote)
                }
            }
            .onDelete {
                📱.deleteNote($0)
                💥Feedback.light()
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
    private var ⓗideMoveButtons: Bool
    var body: some View {
        List {
            Section {
                TextField("Title", text: self.$ⓝote.title)
                    .font(.headline)
                TextField("Comment", text: self.$ⓝote.comment)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Section {
                if !self.ⓗideMoveButtons { self.ⓜoveButtons() }
                Button(role: .destructive) {
                    📱.removeNote(self.ⓝote)
                    self.dismiss()
                } label: {
                    Label("Delete", systemImage: "trash")
                }
            }
        }
    }
    private func ⓜoveButtons() -> some View {
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
    init(_ note: Binding<📗Note>, hideMoveButtons: Bool = false) {
        self._ⓝote = note
        self.ⓗideMoveButtons = hideMoveButtons
    }
}

private struct 📖WidgetNotesSheet: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        NavigationStack {
            List {
                switch 📱.🪧widgetState.info {
                    case .singleNote(let ⓘd):
                        self.ⓝoteLink(ⓘd)
                    case .multiNotes(let ⓘds):
                        ForEach(ⓘds, id: \.self) { self.ⓝoteLink($0) }
                    default:
                        Text("🐛")
                }
            }
        }
    }
    private func ⓝoteLink(_ ⓘd: UUID) -> some View {
        Group {
            if let ⓘndex = 📱.📚notes.firstIndex(where: { $0.id == ⓘd }) {
                NavigationLink {
                    📗NoteView($📱.📚notes[ⓘndex], hideMoveButtons: true)
                } label: {
                    VStack(alignment: .leading) {
                        Text(📱.📚notes[ⓘndex].title)
                            .font(.title3.bold())
                        Text(📱.📚notes[ⓘndex].comment)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 8)
                }
            } else {
                Label("Deleted", systemImage: "checkmark")
            }
        }
    }
}

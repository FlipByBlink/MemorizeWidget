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
        .sheet(isPresented: $📱.🪧widgetState.showSheet) { 📖WidgetNotesSheet() }
    }
}

private struct 📚NotesMenu: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        List {
            TextFieldLink {
                Label("New note", systemImage: "plus")
            } onSubmit: { ⓣext in
                📱.insertOnTop([📗Note(ⓣext)])
            }
            ForEach(📱.📚notes.indices, id: \.self) { ⓘndex in
                NavigationLink {
                    📗NoteView(ⓘndex)
                } label: {
                    VStack(alignment: .leading) {
                        Text(📱.📚notes[ⓘndex].title)
                            .font(.headline)
                            .foregroundStyle(!📱.🚩randomMode && ⓘndex != 0 ? .secondary : .primary)
                        Text(📱.📚notes[ⓘndex].comment)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .onDelete(perform: 📱.deleteNote(_:))
            .onMove(perform: 📱.moveNote(_:_:))
        }
        .navigationTitle("Notes")
    }
}

private struct 📗NoteView: View {
    @EnvironmentObject var 📱: 📱AppModel
    @Environment(\.dismiss) var dismiss
    private var ⓘndex: Int
    private var ⓝote: 📗Note { 📱.📚notes[ⓘndex] }
    var body: some View {
        List {
            Section {
                TextField("Title", text: self.$📱.📚notes[ⓘndex].title)
                    .font(.headline)
                TextField("Comment", text: self.$📱.📚notes[ⓘndex].comment)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            if !📱.🪧widgetState.showSheet { self.ⓜoveButtons() }
            Section {
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
        Section {
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
                .disabled(📱.📚notes.first == self.ⓝote)
                Spacer()
                Text("Move")
                    .font(.headline)
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
                .disabled(📱.📚notes.last == self.ⓝote)
            }
        }
    }
    init(_ index: Int) {
        self.ⓘndex = index
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
                    📗NoteView(ⓘndex)
                } label: {
                    VStack(alignment: .leading) {
                        Text(📱.📚notes[ⓘndex].title)
                            .font(.title3.bold())
                        Text(📱.📚notes[ⓘndex].comment)
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

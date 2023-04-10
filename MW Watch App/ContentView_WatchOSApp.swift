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
                    🔩MenuList()
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
                Button {
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

private struct 🔩MenuList: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        List {
            🔀RandomModeSection()
            📑MultiNotesOption()
            💬CommentOnWidgetSection()
            Section { 🚮DeleteAllNotesButton() }
        }
        .navigationTitle("Menu")
    }
}

private struct 🔀RandomModeSection: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        Section {
            Toggle(isOn: $📱.🚩randomMode) {
                Label("Random mode", systemImage: "shuffle")
            }
            .task(id: 📱.🚩randomMode) { WidgetCenter.shared.reloadAllTimelines() }
        } footer: {
            Text("Change the note per 5 minutes.")
        }
    }
}

private struct 📑MultiNotesOption: View {
    @AppStorage("multiNotes", store: .ⓐppGroup) var 🚩value: Bool = false
    var body: some View {
        Toggle(isOn: self.$🚩value) {
            Label("Show multi notes on widget", systemImage: "doc.on.doc")
                .padding(.vertical, 8)
        }
        .task(id: self.🚩value) { WidgetCenter.shared.reloadAllTimelines() }
    }
}

private struct 💬CommentOnWidgetSection: View {
    @AppStorage("ShowComment", store: .ⓐppGroup) var 🚩value: Bool = false
    @AppStorage("multiNotes", store: .ⓐppGroup) var ⓜultiNotes: Bool = false
    var body: some View {
        Toggle(isOn: self.$🚩value) {
            Label("Show comment on widget", systemImage: "text.append")
                .padding(.vertical, 8)
        }
        .task(id: self.🚩value) { WidgetCenter.shared.reloadAllTimelines() }
        .disabled(self.ⓜultiNotes)
    }
}

private struct 🚮DeleteAllNotesButton: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        Section {
            NavigationLink {
                Self.🄳ialog()
            } label: {
                Label("Delete all notes.", systemImage: "delete.backward.fill")
                    .foregroundColor(📱.📚notes.isEmpty ? nil : .red)
            }
            .disabled(📱.📚notes.isEmpty)
        }
    }
    private struct 🄳ialog: View {
        @EnvironmentObject var 📱: 📱AppModel
        @Environment(\.dismiss) var dismiss
        var body: some View {
            Button(role: .destructive) {
                📱.removeAllNotes()
                self.dismiss()
            } label: {
                Label("OK, delete all notes.", systemImage: "trash")
            }
        }
    }
}

private struct 📖WidgetNotesSheet: View {
    @EnvironmentObject var 📱: 📱AppModel
    private var ⓞnSheet: Bool { 📱.🪧widgetState.showSheet }
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
                            .font(self.ⓞnSheet ? .title3.bold() : .headline)
                            .foregroundStyle(!📱.🚩randomMode && ⓘndex != 0 ? .secondary : .primary)
                        Text(📱.📚notes[ⓘndex].comment)
                            .font(self.ⓞnSheet ? .body : .caption)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, self.ⓞnSheet ? 8 : 0)
                }
            } else {
                Label("Deleted", systemImage: "checkmark")
            }
        }
    }
}

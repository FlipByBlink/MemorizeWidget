import SwiftUI

struct ContentView_WatchOSApp: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        NavigationStack {
            List {
                NavigationLink {
                    📚NotesMenu()
                } label: {
                    Label("Notes", systemImage: "books.vertical")
                }
                NavigationLink {
                    Text("Menu")
                } label: {
                    Label("Menu", systemImage: "gearshape")
                }
            }
            .navigationTitle("MemorizeW")
        }
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
            ForEach($📱.📚notes) { ⓝote in
                NavigationLink {
                    📗NoteView(ⓝote)
                } label: {
                    VStack(alignment: .leading) {
                        Text(ⓝote.wrappedValue.title)
                            .font(.headline)
                        Text(ⓝote.wrappedValue.comment)
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
    @Binding private var ⓝote: 📗Note
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
                Button {
                    📱.removeNote(self.ⓝote)
                    self.dismiss()
                } label: {
                    Label("Delete", systemImage: "trash")
                }
            }
        }
    }
    init(_ ⓝote: Binding<📗Note>) {
        self._ⓝote = ⓝote
    }
}

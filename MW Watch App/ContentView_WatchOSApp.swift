import SwiftUI

struct ContentView: View {
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
            .navigationTitle("MemorizeWidget")
        }
    }
}

private struct 📚NotesMenu: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        List {
            ForEach(📱.📚notes) { ⓝote in
                VStack(alignment: .leading) {
                    Text(ⓝote.title)
                        .font(.headline)
                    Text(ⓝote.comment)
                }
            }
        }
        .navigationTitle("Notes")
    }
}

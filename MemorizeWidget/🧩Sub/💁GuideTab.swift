import SwiftUI

struct 💁GuideTab: View {
    var body: some View {
        NavigationView {
            List {
                🄸mportNotesSection()
                🄳ataSection()
                🄳eleteNoteBySwipingSection()
                if #available(iOS 16.0, *) { 🄳irectionsSection() }
            }
            .navigationTitle("Guide")
        }
        .navigationViewStyle(.stack)
    }
}

private struct 🄳ataSection: View {
    @EnvironmentObject var 📱: 📱AppModel
    private var ⓓataCount: Int { 💾UserDefaults.dataCount(📱.📚notes) }
    var body: some View {
        Section {
            Label("Sync notes between devices by iCloud.", systemImage: "icloud")
            Label("Data limitation is 1 mega byte.", systemImage: "exclamationmark.icloud")
            VStack {
                Label("Notes data count", systemImage: "books.vertical")
                    .badge(self.ⓓataCount.formatted(.byteCount(style: .file)))
                if self.ⓓataCount > 800000 {
                    Text("⚠️ NOTICE DATA LIMITATION")
                        .font(.headline)
                        .foregroundColor(.red)
                        .padding(4)
                }
            }
        } header: {
            Text("Data")
        }
    }
}

private struct 🄸mportNotesSection: View {
    var body: some View {
        Section {
            HStack(spacing: 8) {
                Image(systemName: "photo")
                    .resizable()
                    .frame(width: 140, height: 140)
                    .padding(8)
                Text("Import notes from plain text or text base file(csv, tsv, txt).")
            }
            HStack(spacing: 8) {
                Image(systemName: "photo")
                    .resizable()
                    .frame(width: 140, height: 140)
                    .padding(8)
                Text("Import selected text as notes from other app.")
            }
            HStack(spacing: 8) {
                Image(systemName: "photo")
                    .resizable()
                    .frame(width: 140, height: 140)
                    .padding(8)
                Text("Import a text-base file as notes from other app.")
            }
        } header: {
            Text("Import notes")
        }
    }
}

private struct 🄳eleteNoteBySwipingSection: View {
    var body: some View {
        Section {
            Text("Delete a note by swiping the row.")
            VStack {
                Image(systemName: "photo")
                    .resizable()
                    .frame(width: 160, height: 160)
                HStack {
                    Image(systemName: "hand.point.up.left")
                    Image(systemName: "arrow.left")
                }
                .environment(\.layoutDirection, .leftToRight)
            }
            .padding()
        } header: {
            Text("Tips")
        }
    }
}

private struct 🄳irectionsSection: View {
    var body: some View {
        Section {
            Text("If lock screen widgets don't update, please close this app or switch to another app.")
        } header: {
            Text("Directions")
        }
    }
}

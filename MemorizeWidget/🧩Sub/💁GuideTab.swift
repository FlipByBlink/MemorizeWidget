import SwiftUI

struct 💁GuideTab: View {
    var body: some View {
        NavigationView {
            List {
                🄳ataSection()
                🄸mportNotesSection()
                🄳eleteNoteBySwipingSection()
                🄳irectionsSection()
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
            VStack(spacing: 8) {
                Image("importNotesButton")
                    .shadow(radius: 2, y: 1)
                Text("Import notes from plain text or text base file(csv, tsv, txt).")
            }
            .padding(8)
            HStack(spacing: 8) {
                Image("shareSheetText")
                    .padding(8)
                Text("Import selected text as notes from other app.")
            }
            HStack(spacing: 8) {
                Image("shareSheetFile")
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
            HStack(spacing: 12) {
                HStack(spacing: 4) {
                    Image("deleteBySwiping")
                    Image(systemName: "cursorarrow.motionlines")
                }
                Text("Delete a note by swiping the row.")
            }
            .environment(\.layoutDirection, .leftToRight)
            .padding(8)
        } header: {
            Text("Tips")
        }
    }
}

private struct 🄳irectionsSection: View {
    var body: some View {
        if #available(iOS 16.0, *) {
            Section {
                Text("If lock screen widgets don't update, please close this app or switch to another app.")
            } header: {
                Text("Directions")
            }
        }
    }
}

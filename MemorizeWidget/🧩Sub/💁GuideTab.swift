import SwiftUI

struct 💁GuideTab: View {
    var body: some View {
        NavigationView {
            List {
                🄸mportNotesSection()
                🄸CloudSection()
                🄳eleteNoteBySwipingSection()
                if #available(iOS 16.0, *) { 🄳irectionsSection() }
            }
            .navigationTitle("Guide")
        }
        .navigationViewStyle(.stack)
    }
}

private struct 🄸CloudSection: View {
    var body: some View {
        Section {
            Text("Sync notes between devices by iCloud.")
            Text("Data limitation is 1 mega byte.")
        } header: {
            Text("iCloud")
        }
    }
}

private struct 🄸mportNotesSection: View {
    var body: some View {
        Section {
            Text("Import notes from plain text or text base file(csv, tsv, txt).")
            Image(systemName: "photo")
        } header: {
            Text("Import notes")
        }
    }
}

private struct 🄳eleteNoteBySwipingSection: View {
    var body: some View {
        Section {
            VStack {
                Text("Delete a note by swiping the row.")
                HStack {
                    Image(systemName: "hand.point.up.left")
                    Image(systemName: "arrowshape.left")
                }
            }
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

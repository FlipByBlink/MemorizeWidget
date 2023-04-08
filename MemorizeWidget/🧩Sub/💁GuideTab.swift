import SwiftUI

struct 💁GuideTab: View {
    @EnvironmentObject var 📱: 📱AppModel
    private var ⓔxceedDataSize: Bool { 📱.exceedDataSizePerhaps }
    var body: some View {
        NavigationView {
            List {
                if self.ⓔxceedDataSize { 🄳ataSection() }
                🄸mportNotesSection()
                🄳eleteNoteBySwipingSection()
                if !self.ⓔxceedDataSize { 🄳ataSection() }
                🄰ppleSupportLinkSection()
                🄳irectionsSection()
            }
            .navigationTitle("Guide")
        }
        .navigationViewStyle(.stack)
    }
}

private struct 🄳ataSection: View {
    @EnvironmentObject var 📱: 📱AppModel
    private var ⓓataCount: Int { 📱.📚notes.dataCount }
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
            VStack(spacing: 12) {
                Image("importNotesButton")
                    .shadow(radius: 2, y: 1)
                Text("Import notes from plain text or text base file(csv, tsv, txt).")
            }
            .padding(12)
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
                        .font(.body.weight(.light))
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

private struct 🄰ppleSupportLinkSection: View {
    private var ⓤrl: String {
        UIDevice.current.userInterfaceIdiom == .pad ? "https://support.apple.com/HT211328" : "https://support.apple.com/HT207122"
    }
    var body: some View {
        Section {
            Link(destination: URL(string: self.ⓤrl)!) {
                VStack(alignment: .leading, spacing: 6) {
                    if UIDevice.current.userInterfaceIdiom == .pad {
                        Label("Use widgets on your iPad", systemImage: "link")
                    } else {
                        Label("How to add and edit widgets on your iPhone", systemImage: "link")
                    }
                    HStack {
                        Spacer()
                        Text(self.ⓤrl)
                            .font(.caption2.italic())
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                }
                .padding(.vertical, 4)
            }
            if UIDevice.current.userInterfaceIdiom == .phone {
                Link(destination: URL(string: "https://support.apple.com/guide/iphone/create-a-custom-lock-screen-iph4d0e6c351/ios")!) {
                    VStack(alignment: .leading, spacing: 6) {
                        Label("Create a custom iPhone Lock Screen", systemImage: "link")
                        HStack {
                            Spacer()
                            Text("https://support.apple.com/guide/iphone/create-a-custom-lock-screen-iph4d0e6c351/ios")
                                .font(.caption2.italic())
                                .multilineTextAlignment(.center)
                            Spacer()
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
        } header: {
            Text("Apple Support Page Link")
        }
    }
}

private struct 🄳irectionsSection: View {
    var body: some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            if #available(iOS 16.0, *) {
                Section {
                    Text("If lock screen widgets don't update, please close this app or switch to another app.")
                } header: {
                    Text("Directions")
                }
            }
        }
    }
}

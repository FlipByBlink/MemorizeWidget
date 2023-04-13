import SwiftUI

struct 💁GuideTab: View {
    @EnvironmentObject var 📱: 📱AppModel
    private var ⓔxceedDataSize: Bool { 📱.exceedDataSizePerhaps }
    var body: some View {
        NavigationView {
            List {
                if self.ⓔxceedDataSize { 🄳ataSection() }
                🄸mportNotesSection()
                🅃ipsSection()
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
            Label("If the data size is exceeded, please reduce the number of notes or clear the trash.",
                  systemImage: "externaldrive.badge.xmark")
            if #unavailable(iOS 16) {
                Label("Data changed on another device will be synchronized when the app is launched on this device. (iOS15 only)",
                      systemImage: "exclamationmark.triangle")
            }
            VStack {
                HStack {
                    Label("Notes data count", systemImage: "books.vertical")
                    Spacer()
                    Text(self.ⓓataCount.formatted(.byteCount(style: .file)))
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
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

private struct 🅃ipsSection: View {
    var body: some View {
        Section {
            HStack(spacing: 12) {
                HStack(spacing: 4) {
                    Image("deleteBySwiping")
                        .shadow(radius: 1, y: -1)
                        .shadow(radius: 1, y: 1)
                    Image(systemName: "cursorarrow.motionlines")
                        .font(.body.weight(.light))
                }
                .padding(.vertical, 4)
                Text("Delete a note by swiping the row.")
            }
            if #available(iOS 16.0, *) {
                HStack(spacing: 12) {
                    HStack(spacing: 4) {
                        Image("moveBySwiping")
                            .shadow(radius: 1, y: -1)
                            .shadow(radius: 1, y: 1)
                        Image(systemName: "hand.draw")
                            .font(.body.weight(.light))
                    }
                    .padding(.vertical, 4)
                    Text("Move a note by drag and drop the row.")
                }
            }
        } header: {
            Text("Tips")
        }
        .environment(\.layoutDirection, .leftToRight)
    }
}

private struct 🄰ppleSupportLinkSection: View {
    private var ⓤrl: String {
#if targetEnvironment(macCatalyst)
        "https://support.apple.com/guide/mac-help/add-customize-widgets-notification-center-mchl52be5da5/mac"
#else
        UIDevice.current.userInterfaceIdiom == .pad ? "https://support.apple.com/HT211328" : "https://support.apple.com/HT207122"
#endif
    }
    private var ⓛabel: LocalizedStringKey {
#if targetEnvironment(macCatalyst)
        "Add and customize widgets in Notification Center on Mac"
#else
        UIDevice.current.userInterfaceIdiom == .pad ? "Use widgets on your iPad" : "https://support.apple.com/HT207122"
#endif
    }
    var body: some View {
        Section {
            Link(destination: URL(string: self.ⓤrl)!) {
                VStack(alignment: .leading, spacing: 6) {
                    Label(self.ⓛabel, systemImage: "link")
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
            .accessibilityLabel("Use widgets on your iPad")
            if UIDevice.current.userInterfaceIdiom == .phone, #available(iOS 16.0, *) {
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
                .accessibilityLabel("Create a custom iPhone Lock Screen")
            }
        } header: {
            Text("Apple Support Page Link")
        }
    }
}

private struct 🄳irectionsSection: View {
    var body: some View {
        if UIDevice.current.userInterfaceIdiom == .phone, #available(iOS 16.0, *) {
            Section {
                Text("If lock screen widgets don't update, please close this app or switch to another app.")
            } header: {
                Text("Directions")
            }
        }
    }
}

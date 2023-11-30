import SwiftUI

struct 💁GuideTab: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        NavigationStack {
            List {
                if self.model.notes.exceedDataSizePerhaps { 🄳ataSection() }
                🄸mportNotesSection()
                🅃ipsSection()
                if !self.model.notes.exceedDataSizePerhaps { 🄳ataSection() }
                🄰ppleSupportLinkSection()
                🄳irectionsSection()
            }
            .navigationTitle("Guide")
        }
        .badge(self.model.notes.exceedDataSizePerhaps ? Text(verbatim: "!") : nil)
    }
}

private struct 🄳ataSection: View {
    var body: some View {
        Section {
            💁GuideViewComponent.AboutDataSync()
            if #unavailable(iOS 16) {
                Label("Data changed on another device will be synchronized when the app is launched on this device. (iOS15 only)",
                      systemImage: "exclamationmark.triangle")
            }
            💁GuideViewComponent.AboutDataCount()
        } header: {
            Text("Data")
        }
    }
}

private struct 🄸mportNotesSection: View {
    var body: some View {
        Section {
            VStack(spacing: 12) {
                Image(.importNotesButton)
                    .shadow(radius: 2, y: 1)
                Text("Import notes from plain text or text base file(csv, tsv, txt).")
            }
            .padding(12)
            HStack(spacing: 8) {
                Image(.shareSheetText)
                    .padding(8)
                Text("Import selected text as notes from other app.")
            }
            HStack(spacing: 8) {
                Image(.shareSheetFile)
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
                    Image(.deleteBySwiping)
                        .shadow(radius: 1, y: -1)
                        .shadow(radius: 1, y: 1)
                    Image(systemName: "cursorarrow.motionlines")
                        .font(.body.weight(.light))
                }
                .padding(.vertical, 4)
                Text("Delete a note by swiping the row.")
            }
            HStack(spacing: 12) {
                HStack(spacing: 4) {
                    Image(.moveBySwiping)
                        .shadow(radius: 1, y: -1)
                        .shadow(radius: 1, y: 1)
                    Image(systemName: "hand.draw")
                        .font(.body.weight(.light))
                }
                .padding(.vertical, 4)
                Text("Move a note by drag and drop the row.")
            }
        } header: {
            Text("Tips")
        }
        .environment(\.layoutDirection, .leftToRight)
    }
}

private struct 🄰ppleSupportLinkSection: View {
    private static var urlString: String {
        if UIDevice.current.userInterfaceIdiom == .pad {
            "https://support.apple.com/HT211328"
        } else {
            "https://support.apple.com/HT207122"
        }
    }
    private static var labelTitle: LocalizedStringKey {
        if UIDevice.current.userInterfaceIdiom == .pad {
            "Use widgets on your iPad"
        } else {
            "How to add and edit widgets on your iPhone"
        }
    }
    private static var supportLockScreenWidget: Bool {
        if #available(iOS 17.0, *) {
            true
        } else {
            UIDevice.current.userInterfaceIdiom == .phone
        }
    }
    private static var linkForLockScreenWidget: URL {
        if UIDevice.current.userInterfaceIdiom == .phone {
            .init(string: "https://support.apple.com/guide/iphone/create-a-custom-lock-screen-iph4d0e6c351/ios")!
        } else {
            .init(string: "https://support.apple.com/guide/ipad/create-a-custom-lock-screen-ipad782d4de8/17.0/ipados/17.0")!
        }
    }
    var body: some View {
        Section {
            Link(destination: .init(string: Self.urlString)!) {
                VStack(alignment: .leading, spacing: 6) {
                    Label(Self.labelTitle, systemImage: "link")
                    HStack {
                        Spacer()
                        Text(Self.urlString)
                            .font(.caption2.italic())
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                }
                .padding(.vertical, 4)
            }
            .accessibilityLabel(Self.labelTitle)
            if Self.supportLockScreenWidget {
                let ⓣitle = if UIDevice.current.userInterfaceIdiom == .phone {
                    Text("Create a custom iPhone Lock Screen")
                } else {
                    Text("Create a custom iPad Lock Screen")
                }
                Link(destination: Self.linkForLockScreenWidget) {
                    VStack(alignment: .leading, spacing: 6) {
                        Label {
                            ⓣitle
                        } icon: {
                            Image(systemName: "link")
                        }
                        HStack {
                            Spacer()
                            Text(verbatim: Self.linkForLockScreenWidget.formatted())
                                .font(.caption2.italic())
                                .multilineTextAlignment(.center)
                            Spacer()
                        }
                    }
                    .padding(.vertical, 4)
                }
                .accessibilityLabel(ⓣitle)
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

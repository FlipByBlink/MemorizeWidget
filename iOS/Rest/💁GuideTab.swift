import SwiftUI

struct 💁GuideTab: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        NavigationStack {
            List {
                if self.model.exceedDataSizePerhaps { 🄳ataSection() }
                🄸mportNotesSection()
                🅃ipsSection()
                if !self.model.exceedDataSizePerhaps { 🄳ataSection() }
                🄰ppleSupportLinkSection()
                🄳irectionsSection()
            }
            .navigationTitle("Guide")
        }
    }
}

private struct 🄳ataSection: View {
    @EnvironmentObject var model: 📱AppModel
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
        } header: {
            Text("Tips")
        }
        .environment(\.layoutDirection, .leftToRight)
    }
}

private struct 🄰ppleSupportLinkSection: View {
    private var urlString: String {
#if targetEnvironment(macCatalyst)
        "https://support.apple.com/guide/mac-help/add-customize-widgets-notification-center-mchl52be5da5/mac"
#else
        if UIDevice.current.userInterfaceIdiom == .pad {
            "https://support.apple.com/HT211328"
        } else {
            "https://support.apple.com/HT207122"
        }
#endif
    }
    private var labelTitle: LocalizedStringKey {
#if targetEnvironment(macCatalyst)
        "Add and customize widgets in Notification Center on Mac"
#else
        if UIDevice.current.userInterfaceIdiom == .pad {
            "Use widgets on your iPad"
        } else {
            "How to add and edit widgets on your iPhone"
        }
#endif
    }
    var body: some View {
        Section {
            Link(destination: .init(string: self.urlString)!) {
                VStack(alignment: .leading, spacing: 6) {
                    Label(self.labelTitle, systemImage: "link")
                    HStack {
                        Spacer()
                        Text(self.urlString)
                            .font(.caption2.italic())
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                }
                .padding(.vertical, 4)
            }
            .accessibilityLabel(self.labelTitle)
            if UIDevice.current.userInterfaceIdiom == .phone, #available(iOS 16.0, *) {
                Link(destination: .init(string: "https://support.apple.com/guide/iphone/create-a-custom-lock-screen-iph4d0e6c351/ios")!) {
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

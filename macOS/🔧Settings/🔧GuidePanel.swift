import SwiftUI

struct 🔧GuidePanel: View {
    var body: some View {
        Form {
            💁GuideViewComponent.AboutDataSync()
            💁GuideViewComponent.AboutDataCount()
            🄰ppleSupportLinkSection()
        }
        .formStyle(.grouped)
        .tabItem {
            Label("Guide", systemImage: "questionmark")
        }
    }
}

private struct 🄰ppleSupportLinkSection: View {
    private static var urlString: String {
        "https://support.apple.com/guide/mac-help/add-customize-widgets-notification-center-mchl52be5da5/mac"
    }
    private static var labelTitle: LocalizedStringKey {
        "Add and customize widgets in Notification Center on Mac"
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
        } header: {
            Text("Apple Support Page Link")
        }
    }
}

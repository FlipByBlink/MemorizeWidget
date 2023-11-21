import SwiftUI

struct 🔧GuidePanel: View {
    var body: some View {
        Form {
            Section {
                💁GuideViewComponent.AboutDataSync()
                💁GuideViewComponent.AboutDataCount()
            } header: {
                Text("Data")
            }
            Self.AppleSupportLinkSection()
        }
        .formStyle(.grouped)
        .tabItem {
            Label("Guide", systemImage: "questionmark")
        }
    }
}

private extension 🔧GuidePanel {
    private struct AppleSupportLinkSection: View {
        private static var urlString: String {
            "https://support.apple.com/guide/mac-help/add-and-customize-widgets-mchl52be5da5/mac"
        }
        var body: some View {
            Section {
                Link(destination: .init(string: Self.urlString)!) {
                    Label("Add and customize widgets on Mac", systemImage: "link")
                }
            } header: {
                Text("Apple Support Page Link")
            } footer: {
                Text(Self.urlString)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

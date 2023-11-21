import SwiftUI

struct 🔧SearchCustomizePanel: View {
    @StateObject var model: 🔍SearchModel = .init()
    @Environment(\.openURL) var openURL
    var body: some View {
        Form {
            Spacer()
            self.previewView()
            TextField("Leading component", text: self.$model.inputtedLeadingText)
                .accessibilityLabel("Leading component")
            TextField("Trailing component", text: self.$model.trailingText)
                .accessibilityLabel("Trailing component")
                .font(.subheadline)
            Spacer(minLength: 16)
            self.testButton()
            Spacer(minLength: 16)
            GroupBox {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Use the web search service with the note title.")
                    Text("Pre-installed shortcut to search in DuckDuckGo.")
                }
                .padding(8)
            }
            Spacer()
        }
        .padding(24)
        .tabItem {
            Label("Search", systemImage: "magnifyingglass")
        }
    }
}

private extension 🔧SearchCustomizePanel {
    private func previewView() -> some View {
        Text(self.model.entireText("NOTETITLE"))
            .font(.subheadline.monospaced().italic())
            .multilineTextAlignment(.center)
            .padding(8)
            .frame(height: 70)
            .animation(.default, value: self.model.inputtedLeadingText.isEmpty)
            .foregroundStyle(
                self.model.inputtedLeadingText.isEmpty ? .secondary : .primary
            )
    }
    private func testButton() -> some View {
        Button {
            self.openURL(self.model.generateURL("NOTETITLE")) {
                if $0 == false { self.model.alertOpenURLFailure = true }
            }
        } label: {
            Label("Test", systemImage: "magnifyingglass")
        }
        .modifier(🔍FailureAlert(self.model))
    }
}

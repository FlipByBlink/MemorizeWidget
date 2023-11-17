import SwiftUI

struct 🔍CustomizeSearchMenu: View {
    @StateObject private var model: 🔍SearchModel = .init()
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.openURL) var openURL
    @State private var presentTestSheet: Bool = false
    var body: some View {
        List {
            Section {
                Text("Use the web search service with the note title.")
            } footer: {
                Text("Pre-installed shortcut to search in DuckDuckGo.")
            }
            Section {
                VStack {
                    self.previewView()
                    TextField("Leading component",
                              text: self.$model.inputtedLeadingText)
                    .accessibilityLabel("Leading component")
                    TextField("Trailing component",
                              text: self.$model.trailingText)
                    .accessibilityLabel("Trailing component")
                    .font(.subheadline)
                    .padding(.bottom, 6)
                }
                .textFieldStyle(.roundedBorder)
            } header: {
                Text("Edit URL")
            } footer: {
                Text(#"The prefix must contain "http://" or "https://""#)
            }
            Section { self.testButton() }
            Section {
                Toggle(isOn: self.model.$openURLInOtherApp) {
                    Label("Open the URL in other apps", systemImage: "arrow.up.forward.app")
                }
            }
        }
        .navigationTitle("Customize search")
        .onChange(of: self.scenePhase) { _ in self.presentTestSheet = false }
    }
}

private extension 🔍CustomizeSearchMenu {
    private func previewView() -> some View {
        Text(self.model.entireText("NOTETITLE"))
            .italic()
            .font(.system(.caption, design: .monospaced))
            .multilineTextAlignment(.center)
            .padding(8)
            .frame(minHeight: 100)
            .animation(.default, value: self.model.inputtedLeadingText.isEmpty)
            .foregroundStyle(
                self.model.inputtedLeadingText.isEmpty ? .secondary : .primary
            )
    }
    private func testButton() -> some View {
        Button {
            if self.model.openURLInOtherApp {
                self.openURL(self.model.generateURL("NOTETITLE"))
            } else {
                self.presentTestSheet = true
            }
        } label: {
            Label("Test", systemImage: "magnifyingglass")
                .fontWeight(.semibold)
        }
        .disabled(!self.model.ableInAppSearch)
        .sheet(isPresented: self.$presentTestSheet) {
            🔍SearchSheetView(self.model.generateURL("NOTETITLE"))
        }
    }
}

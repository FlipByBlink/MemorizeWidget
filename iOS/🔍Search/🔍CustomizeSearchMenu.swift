import SwiftUI

struct 🔍CustomizeSearchMenu: View {
    @StateObject private var model: 🔍SearchModel = .init()
    @Environment(\.scenePhase) var scenePhase
    @State private var presentTestSheet: Bool = false
    var body: some View {
        List {
            Section {
                Text("Use the web search service with the note title.")
            }
            Section {
                VStack {
                    self.previewView()
                    HStack {
                        Text(verbatim: "https://")
                            .fontWeight(.medium)
                            .foregroundStyle(.secondary)
                        TextField("Leading component",
                                  text: self.$model.inputtedLeadingText)
                        .accessibilityLabel("Leading component")
                    }
                    TextField("Trailing component",
                              text: self.$model.trailingText)
                    .accessibilityLabel("Trailing component")
                    .font(.subheadline)
                    .padding(.bottom, 6)
                }
                .textFieldStyle(.roundedBorder)
            } header: {
                Text("Edit URL")
            }
            Section { self.testButton() }
            Section {
                Text("Pre-installed shortcut to search in DuckDuckGo.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .padding(.vertical, 4)
            } header: {
                Text("Pre-install")
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
            self.presentTestSheet = true
        } label: {
            Label("Test", systemImage: "magnifyingglass")
        }
        .sheet(isPresented: self.$presentTestSheet) {
            🔍SearchSheetView(self.model.generateURL("NOTETITLE"))
        }
    }
}

import SwiftUI

struct 🔍CustomizeSearchSheetView: View {
    @StateObject private var model: 🔍SearchModel = .init()
    @State private var presentTestSheet: Bool = false
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Text("ノートのタイトルでWebサービスを検索できます。")
                }
                Section {
                    VStack {
                        self.previewView()
                        TextField("Leading component", 
                                  text: self.$model.inputtedLeadingText)
                        TextField("Trailing component",
                                  text: self.$model.trailingText)
                        .font(.subheadline)
                        .padding(.bottom, 6)
                    }
                    .textFieldStyle(.roundedBorder)
                } header: {
                    Text("URL scheme")
                }
                Section { self.tryButton() }
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
            .toolbar { 📰DismissButton() }
        }
    }
}

private extension 🔍CustomizeSearchSheetView {
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
    private func tryButton() -> some View {
        Button {
            self.presentTestSheet = true
        } label: {
            Label("Test", systemImage: "magnifyingglass")
        }
        .sheet(isPresented: self.$presentTestSheet) {
            🔍BrowserView(url: self.model.generateURL("NOTETITLE"))
        }
    }
}

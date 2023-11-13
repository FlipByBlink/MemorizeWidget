import SwiftUI

struct 🔍CustomizeSearchSheetView: View {
    @AppStorage("SearchLeadingText") var inputtedLeadingText: String = ""
    @AppStorage("SearchTrailingText") var trailingText: String = ""
    private var entireText: String {
        let ⓛeadingText = if self.inputtedLeadingText.isEmpty {
            "https://duckduckgo.com/?q="
        } else {
            self.inputtedLeadingText
        }
        return ⓛeadingText + "NOTETITLE" + self.trailingText
    }
    var body: some View {
        NavigationStack {
            List {
                Section {
                    VStack {
                        Text(self.entireText)
                            .italic()
                            .font(.system(.caption, design: .monospaced))
                            .multilineTextAlignment(.center)
                            .padding(8)
                            .frame(minHeight: 100)
                            .animation(.default, value: self.inputtedLeadingText.isEmpty)
                            .foregroundStyle(self.inputtedLeadingText.isEmpty ? .secondary : .primary)
                        TextField("Leading component", text: self.$inputtedLeadingText)
                        TextField("Trailing component", text: self.$trailingText)
                            .font(.subheadline)
                            .padding(.bottom, 6)
                    }
                    .textFieldStyle(.roundedBorder)
                } header: {
                    Text("Customize URL scheme")
                }
                Section {
                    🔍SearchButton(.init("NOTETITLE"))
                } header: {
                    Text("Test")
                }
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

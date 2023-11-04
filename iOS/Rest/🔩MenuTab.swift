import SwiftUI
import WidgetKit

struct 🔩MenuTab: View {
    var body: some View {
        NavigationStack {
            List {
                📑MultiNotesOption()
                💬CommentOnWidgetSection()
                Section {
                    🔍CustomizeSearchRow()
                    📤ExportNotesRow()
                }
                🚮DeleteAllNotesButton()
            }
            .navigationTitle("Menu")
        }
    }
}

private struct 📑MultiNotesOption: View {
    @AppStorage("multiNotes", store: .ⓐppGroup) var value: Bool = false
    var body: some View {
        Section {
            Toggle(isOn: self.$value) {
                Label("Show multi notes on widget", systemImage: "doc.on.doc")
                    .padding(.vertical, 8)
            }
            .onChange(of: self.value) { _ in
                WidgetCenter.shared.reloadAllTimelines()
            }
            VStack(spacing: 12) {
                🏞BeforeAfterImage("home_multiNotes_before",
                                   "home_multiNotes_after")
                if UIDevice.current.userInterfaceIdiom == .phone {
                    🏞BeforeAfterImage("lockscreen_multiNotes_before",
                                       "lockscreen_multiNotes_after")
                }
            }
            .padding()
        } header: {
            Text("Option")
        }
    }
}

private struct 💬CommentOnWidgetSection: View {
    @AppStorage("ShowComment", store: .ⓐppGroup) var value: Bool = false
    var body: some View {
        Section {
            Toggle(isOn: self.$value) {
                Label("Show comment on widget", systemImage: "text.append")
                    .padding(.vertical, 8)
            }
            .onChange(of: self.value) { _ in
                WidgetCenter.shared.reloadAllTimelines()
            }
            VStack(spacing: 12) {
                🏞BeforeAfterImage("homeSmall_commentOff", "homeSmall_commentOn")
                if UIDevice.current.userInterfaceIdiom == .phone {
                    🏞BeforeAfterImage("lockscreen_commentOff", "lockscreen_commentOn")
                }
            }
            .padding()
        }
    }
}

private struct 🔍CustomizeSearchRow: View {
    var body: some View {
        NavigationLink {
            Self.Destination()
        } label: {
            Label("Customize search button", systemImage: "magnifyingglass")
        }
    }
    private struct Destination: View {
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
                    🔍SearchButton(📗Note("NOTETITLE"))
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
            .navigationTitle("Search button")
        }
    }
}

private struct 📤ExportNotesRow: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        NavigationLink {
            Self.Destination()
        } label: {
            Label("Export notes as text", systemImage: "square.and.arrow.up")
        }
        .disabled(self.model.notes.isEmpty)
        .animation(.default, value: self.model.notes.isEmpty)
    }
    private struct Destination: View {
        @EnvironmentObject var model: 📱AppModel
        private var text: String {
            self.model.notes.reduce(into: "") { ⓟartialResult, ⓝote in
                var ⓣempNote = ⓝote
                ⓣempNote.title.removeAll(where: { $0 == "\n" })
                ⓣempNote.comment.removeAll(where: { $0 == "\n" })
                ⓟartialResult += ⓣempNote.title + "\t" + ⓣempNote.comment
                if ⓝote != self.model.notes.last { ⓟartialResult += "\n" }
            }
        }
        var body: some View {
            List {
                Section {
                    Label("Notes count", systemImage: "books.vertical")
                        .badge(self.model.notes.count)
                    ScrollView(.horizontal) {
                        Text(self.text)
                            .font(.subheadline.monospaced().italic())
                            .textSelection(.enabled)
                            .lineLimit(50)
                            .padding()
                    }
                    Label("Copy the above text", systemImage: "hand.point.up.left")
                        .foregroundStyle(.secondary)
                    ShareLink(item: self.text)
                } header: {
                    Text("Plain text")
                } footer: {
                    Text("This text is TSV(tab-separated values) format.")
                }
            }
            .navigationTitle("Export notes")
        }
    }
}

private struct 🚮DeleteAllNotesButton: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        Section {
            Menu {
                Button(role: .destructive) {
                    self.model.removeAllNotes()
                } label: {
                    Label("OK, delete all notes.", systemImage: "trash")
                }
            } label: {
                ZStack(alignment: .leading) {
                    Color.clear
                    Label("Delete all notes.", systemImage: "delete.backward.fill")
                        .foregroundColor(self.model.notes.isEmpty ? nil : .red)
                }
            }
            .disabled(self.model.notes.isEmpty)
        }
    }
}

private struct 🏞BeforeAfterImage: View {
    private var before: String
    private var after: String
    var body: some View {
        HStack {
            Image(self.before)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 200)
                .cornerRadius(16)
                .shadow(radius: 2)
            Image(systemName: "arrow.right")
                .font(.title2.weight(.semibold))
                .foregroundStyle(.secondary)
            Image(self.after)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 200)
                .cornerRadius(16)
                .shadow(radius: 2)
        }
    }
    init(_ before: String, _ after: String) {
        self.before = before
        self.after = after
    }
}

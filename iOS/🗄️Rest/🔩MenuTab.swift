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
    @AppStorage("multiNotes", store: .ⓐppGroup) var 🚩value: Bool = false
    var body: some View {
        Section {
            Toggle(isOn: self.$🚩value) {
                Label("Show multi notes on widget", systemImage: "doc.on.doc")
                    .padding(.vertical, 8)
            }
            .onChange(of: self.🚩value) { _ in
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
    @AppStorage("ShowComment", store: .ⓐppGroup) var 🚩value: Bool = false
    var body: some View {
        Section {
            Toggle(isOn: self.$🚩value) {
                Label("Show comment on widget", systemImage: "text.append")
                    .padding(.vertical, 8)
            }
            .onChange(of: self.🚩value) { _ in
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
            Self.🄼enu()
        } label: {
            Label("Customize search button", systemImage: "magnifyingglass")
        }
    }
    private struct 🄼enu: View {
        @EnvironmentObject var 📱: 📱AppModel
        @AppStorage("SearchLeadingText") var 🔗leading: String = ""
        @AppStorage("SearchTrailingText") var 🔗trailing: String = ""
        private var ⓔntireText: String {
            let ⓛeading = self.🔗leading.isEmpty ? "https://duckduckgo.com/?q=" : self.🔗leading
            return ⓛeading + "NOTETITLE" + self.🔗trailing
        }
        var body: some View {
            List {
                Section {
                    VStack {
                        Text(self.ⓔntireText)
                            .italic()
                            .font(.system(.caption, design: .monospaced))
                            .multilineTextAlignment(.center)
                            .padding(8)
                            .frame(minHeight: 100)
                            .animation(.default, value: self.🔗leading.isEmpty)
                            .foregroundStyle(self.🔗leading.isEmpty ? .secondary : .primary)
                        TextField("Leading component", text: self.$🔗leading)
                        TextField("Trailing component", text: self.$🔗trailing)
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
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        NavigationLink {
            Self.🄼enu()
        } label: {
            Label("Export notes as text", systemImage: "square.and.arrow.up")
        }
        .disabled(📱.📚notes.isEmpty)
        .animation(.default, value: 📱.📚notes.isEmpty)
    }
    private struct 🄼enu: View {
        @EnvironmentObject var 📱: 📱AppModel
        private var ⓣext: String {
            📱.📚notes.reduce(into: "") { ⓟartialResult, ⓝote in
                var ⓣempNote = ⓝote
                ⓣempNote.title.removeAll(where: { $0 == "\n" })
                ⓣempNote.comment.removeAll(where: { $0 == "\n" })
                ⓟartialResult += ⓣempNote.title + "\t" + ⓣempNote.comment
                if ⓝote != 📱.📚notes.last { ⓟartialResult += "\n" }
            }
        }
        var body: some View {
            List {
                Section {
                    Label("Notes count", systemImage: "books.vertical")
                        .badge(📱.📚notes.count)
                    ScrollView(.horizontal) {
                        Text(self.ⓣext)
                            .font(.subheadline.monospaced().italic())
                            .textSelection(.enabled)
                            .lineLimit(50)
                            .padding()
                    }
                    Label("Copy the above text", systemImage: "hand.point.up.left")
                        .foregroundStyle(.secondary)
                    ShareLink(item: self.ⓣext)
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
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        Section {
            Menu {
                Button(role: .destructive, action: 📱.removeAllNotes) {
                    Label("OK, delete all notes.", systemImage: "trash")
                }
            } label: {
                ZStack(alignment: .leading) {
                    Color.clear
                    Label("Delete all notes.", systemImage: "delete.backward.fill")
                        .foregroundColor(📱.📚notes.isEmpty ? nil : .red)
                }
            }
            .disabled(📱.📚notes.isEmpty)
        }
    }
}

private struct 🏞BeforeAfterImage: View {
    private var ⓑefore: String
    private var ⓐfter: String
    var body: some View {
        HStack {
            Image(self.ⓑefore)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 200)
                .cornerRadius(16)
                .shadow(radius: 2)
            Image(systemName: "arrow.right")
                .font(.title2.weight(.semibold))
                .foregroundStyle(.secondary)
            Image(self.ⓐfter)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 200)
                .cornerRadius(16)
                .shadow(radius: 2)
        }
    }
    init(_ before: String, _ after: String) {
        self.ⓑefore = before
        self.ⓐfter = after
    }
}

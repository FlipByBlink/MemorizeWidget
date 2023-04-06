import SwiftUI
import WidgetKit

struct 🔩MenuTab: View {
    var body: some View {
        NavigationView {
            List {
                📑MultiNotesOption()
                💬CommentOnWidgetSection()
                Section {
                    🔍CustomizeSearchRow()
                    📤ExportNotesRow()
                    🗑TrashRow()
                }
                🚮DeleteAllNotesButton()
            }
            .navigationTitle("Menu")
        }
        .navigationViewStyle(.stack)
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
            .task(id: self.🚩value) { WidgetCenter.shared.reloadAllTimelines() }
            VStack(spacing: 12) {
                🏞BeforeAfterImage("home_multiNotes_before",
                                   "home_multiNotes_after")
                if UIDevice.current.userInterfaceIdiom == .phone {
                    if #available(iOS 16.0, *) {
                        🏞BeforeAfterImage("lockscreen_multiNotes_before",
                                           "lockscreen_multiNotes_after")
                    }
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
            .task(id: self.🚩value) { WidgetCenter.shared.reloadAllTimelines() }
            VStack(spacing: 12) {
                🏞BeforeAfterImage("homeSmall_commentOff", "homeSmall_commentOn")
                if UIDevice.current.userInterfaceIdiom == .phone {
                    if #available(iOS 16.0, *) {
                        🏞BeforeAfterImage("lockscreen_commentOff", "lockscreen_commentOn")
                    }
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
                ⓟartialResult += ⓝote.title + "\t" + ⓝote.comment
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
                    if #available(iOS 16.0, *) {
                        ShareLink(item: self.ⓣext)
                    } else {
                        Label("Copy the above text", systemImage: "hand.point.up.left")
                            .foregroundStyle(.secondary)
                    }
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

private struct 🗑TrashRow: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        NavigationLink {
            Self.🄼enu()
        } label: {
            Label("Trash", systemImage: "trash")
                .badge(📱.🗑trash.deletedContents.count)
        }
    }
    private struct 🄼enu: View {
        @EnvironmentObject var 📱: 📱AppModel
        var body: some View {
            List {
                ForEach(📱.🗑trash.deletedContents) {
                    self.ⓒontentSection($0)
                }
                self.ⓔmptyTrashView()
                self.ⓐboutTrashSection()
            }
            .navigationTitle("Trash")
            .toolbar { self.ⓒlearButton() }
            .animation(.default, value: 📱.🗑trash.deletedContents)
        }
        private func ⓒontentSection(_ ⓒontent: 🄳eletedContent) -> some View {
            Section {
                if ⓒontent.notes.count == 1 {
                    self.ⓢingleNoteRow(ⓒontent)
                } else {
                    self.ⓜultiNotesRows(ⓒontent)
                }
            } header: {
                Text(ⓒontent.date, style: .offset)
                +
                Text(" (\(ⓒontent.date.formatted(.dateTime.month().day().hour().minute())))")
            }
        }
        private func ⓢingleNoteRow(_ ⓒontent: 🄳eletedContent) -> some View {
            HStack {
                self.ⓝoteView(ⓒontent.notes.first ?? .init("🐛"))
                Spacer()
                self.ⓡestoreButton(ⓒontent)
                    .labelStyle(.iconOnly)
                    .buttonStyle(.plain)
                    .font(.title)
                    .symbolRenderingMode(.hierarchical)
                    .foregroundColor(.secondary)
                    .padding(4)
            }
        }
        private func ⓜultiNotesRows(_ ⓒontent: 🄳eletedContent) -> some View {
            Group {
                ForEach(ⓒontent.notes) { self.ⓝoteView($0) }
                self.ⓡestoreButton(ⓒontent)
            }
        }
        private func ⓝoteView(_ ⓝote: 📗Note) -> some View {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text(ⓝote.title)
                        .font(.headline)
                    Text(ⓝote.comment)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .padding(8)
            }
        }
        private func ⓡestoreButton(_ ⓒontent: 🄳eletedContent) -> some View {
            Button {
                📱.restore(ⓒontent)
            } label: {
                Label("Restore", systemImage: "arrow.uturn.backward.circle.fill")
            }
        }
        private func ⓒlearButton() -> some View {
            Menu {
                Button(role: .destructive) {
                    📱.🗑trash.clearDeletedContents()
                } label: {
                    Label("Clear trash", systemImage: "trash.slash")
                }
            } label: {
                Label("Clear trash", systemImage: "trash.slash")
            }
            .tint(.red)
            .disabled(📱.🗑trash.deletedContents.isEmpty)
        }
        private func ⓔmptyTrashView() -> some View {
            Group {
                if 📱.🗑trash.deletedContents.isEmpty {
                    ZStack {
                        Color.clear
                        Label("Empty", systemImage: "xmark.bin")
                            .font(.title2)
                            .foregroundStyle(.secondary)
                    }
                    .padding(32)
                    .listRowBackground(Color.clear)
                }
            }
        }
        private func ⓐboutTrashSection() -> some View {
            Section {
                Label("After 7 days, the notes will be permanently deleted.",
                      systemImage: "clock.badge.exclamationmark")
                Label("Trash do not sync with iCloud.", systemImage: "xmark.icloud")
            }
            .font(.subheadline)
            .foregroundStyle(.secondary)
            .listRowBackground(Color.clear)
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
                .cornerRadius(16)
                .shadow(radius: 2)
            Image(systemName: "arrow.right")
                .font(.title2.weight(.semibold))
                .foregroundStyle(.secondary)
            Image(self.ⓐfter)
                .resizable()
                .scaledToFit()
                .cornerRadius(16)
                .shadow(radius: 2)
        }
        .frame(maxHeight: 200)
    }
    init(_ before: String, _ after: String) {
        self.ⓑefore = before
        self.ⓐfter = after
    }
}

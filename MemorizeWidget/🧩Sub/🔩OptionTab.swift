import SwiftUI
import WidgetKit

struct 🔩OptionTab: View {
    var body: some View {
        NavigationView {
            List {
                📑MultiNotesOption()
                💬CommentOnWidgetSection()
                🔍CustomizeSearchSection()
                if #available(iOS 16.0, *) { 🄳irectionsSection() }
                🚮DeleteAllNotesButton()
            }
            .navigationTitle("Option")
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

private struct 🔍CustomizeSearchSection: View {
    @AppStorage("SearchLeadingText") var 🔗leading: String = ""
    @AppStorage("SearchTrailingText") var 🔗trailing: String = ""
    private var ⓔntireText: String {
        let ⓛeading = self.🔗leading.isEmpty ? "https://duckduckgo.com/?q=" : self.🔗leading
        return ⓛeading + "NOTETITLE" + self.🔗trailing
    }
    var body: some View {
        Section {
            VStack {
                Text(self.ⓔntireText)
                    .italic()
                    .font(.system(.footnote, design: .monospaced))
                    .multilineTextAlignment(.center)
                    .padding(8)
                    .frame(minHeight: 100)
                    .animation(.default, value: self.🔗leading.isEmpty)
                    .foregroundStyle(self.🔗leading.isEmpty ? .secondary : .primary)
                TextField("URL scheme", text: self.$🔗leading)
                TextField("Trailing component", text: self.$🔗trailing)
                    .font(.caption)
                    .padding(.bottom, 4)
            }
            .textFieldStyle(.roundedBorder)
        } header: {
            Label("Customize search", systemImage: "magnifyingglass")
        } footer: {
            Text("Pre-installed shortcut to search in DuckDuckGo.")
        }
        .headerProminence(.increased)
    }
}

private struct 🄳irectionsSection: View {
    var body: some View {
        Section {
            Text("If lock screen widgets don't update, please close this app or switch to another app.")
        } header: {
            Text("Directions")
        }
    }
}

private struct 🚮DeleteAllNotesButton: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        Menu {
            Button(role: .destructive, action: 📱.removeAllNotes) {
                Label("OK, delete all notes.", systemImage: "trash")
            }
        } label: {
            ZStack {
                Color.clear
                Label("Delete all notes.", systemImage: "trash")
                    .foregroundColor(📱.📚notes.isEmpty ? nil : .red)
            }
        }
        .disabled(📱.📚notes.isEmpty)
    }
}

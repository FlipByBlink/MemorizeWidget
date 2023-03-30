import SwiftUI
import WidgetKit

struct 🔩OptionTab: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        NavigationView {
            List {
                Self.💬CommentOnWidgetSection()
                Self.🔍CustomizeSearchSection()
                if #available(iOS 16.0, *) { self.ⓓirectionsSection() }
                self.💣deleteAllNotesButton()
            }
            .navigationTitle("Option")
        }
        .navigationViewStyle(.stack)
    }
    private struct 💬CommentOnWidgetSection: View {
        @AppStorage("ShowComment", store: 💾AppGroupUD) var 🚩showComment: Bool = false
        var body: some View {
            Section {
                Toggle(isOn: self.$🚩showComment) {
                    Label("Show comment on widget", systemImage: "text.append")
                        .padding(.vertical, 8)
                }
                .onChange(of: self.🚩showComment) { _ in
                    WidgetCenter.shared.reloadAllTimelines()
                }
                VStack(spacing: 16) {
                    self.🏞beforeAfterImage("homeSmall_commentOff", "homeSmall_commentOn")
                    if #available(iOS 16.0, *) {
                        self.🏞beforeAfterImage("lockscreen_commentOff", "lockscreen_commentOn")
                    }
                }
                .padding()
                .frame(maxHeight: 500)
            }
        }
        private func 🏞beforeAfterImage(_ ⓑefore: String, _ ⓐfter: String) -> some View {
            HStack {
                Image(ⓑefore)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(16)
                    .shadow(radius: 2)
                    .rotationEffect(.degrees(1))
                Image(systemName: "arrow.right")
                    .font(.title2.weight(.semibold))
                    .foregroundStyle(.secondary)
                Image(ⓐfter)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(16)
                    .shadow(radius: 2)
                    .rotationEffect(.degrees(1))
            }
        }
    }
    private struct 🔍CustomizeSearchSection: View {
        @AppStorage("SearchLeadingText") var 🔗leading: String = ""
        @AppStorage("SearchTrailingText") var 🔗trailing: String = ""
        var body: some View {
            Section {
                VStack {
                    let ⓛeading = self.🔗leading.isEmpty ? "https://duckduckgo.com/?q=" : self.🔗leading
                    Text(ⓛeading + "NOTETITLE" + self.🔗trailing)
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
    private func ⓓirectionsSection() -> some View {
        Section {
            Text("If lock screen widgets don't update, please close this app or switch to another app.")
        } header: {
            Text("Directions")
        }
    }
    private func 💣deleteAllNotesButton() -> some View {
        Menu {
            Button(role: .destructive) {
                📱.📚notes.removeAll()
                UINotificationFeedbackGenerator().notificationOccurred(.error)
            } label: {
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

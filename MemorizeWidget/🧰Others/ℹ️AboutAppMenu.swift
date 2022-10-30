
let 📜VersionsInfo: [(ⓝumber: String, ⓓate: String)] = [("1.1", "2022-10-30"),
                                                        ("1.0.2", "2022-09-16"),
                                                        ("1.0.1", "2022-09-11"),
                                                        ("1.0", "2022-09-09")]

let 🔗AppStoreProductURL = URL(string: "https://apps.apple.com/app/id1644276262")!

let 👤PrivacyPolicy = """
2022-09-08

(English) This application don't collect user infomation.

(Japanese) このアプリ自身において、ユーザーの情報を一切収集しません。
"""

let 🔗WebRepositoryURL = URL(string: "https://github.com/FlipByBlink/MemorizeWidget")!
let 🔗WebRepositoryURL_Mirror = URL(string: "https://gitlab.com/FlipByBlink/MemorizeWidget_Mirror")!

enum 📁SourceFolder: String, CaseIterable, Identifiable {
    case main
    case 🧰Others
    var id: String { self.rawValue }
}




import SwiftUI

struct ℹ️AboutAppMenu: View {
    var body: some View {
        List {
            📰AppStoreDescriptionSection()
            📜VersionHistoryLink()
            👤PrivacyPolicySection()
            🔗AppStoreLink.withURLFooter()
            📓SourceCodeLink()
            🧑‍💻AboutDeveloperPublisherLink()
        }
        .navigationTitle("About App")
    }
}

struct 📰AppStoreDescriptionSection: View {
    var body: some View {
        Section {
            NavigationLink {
                ScrollView {
                    Text("AppStoreDescription", tableName: "🌏AppStoreDescription")
                        .padding()
                }
                .navigationBarTitle("Description")
                .navigationBarTitleDisplayMode(.inline)
                .textSelection(.enabled)
            } label: {
                Text("AppStoreDescription", tableName: "🌏AppStoreDescription")
                    .font(.subheadline)
                    .lineLimit(7)
                    .padding(8)
                    .accessibilityLabel("Description")
            }
        } header: {
            Text("Description")
        }
    }
}

struct 🔗AppStoreLink: View {
    @Environment(\.openURL) var 🔗: OpenURLAction
    var body: some View {
        Button {
            🔗.callAsFunction(🔗AppStoreProductURL)
        } label: {
            HStack {
                Label("Open AppStore page", systemImage: "link")
                Spacer()
                Image(systemName: "arrow.up.forward.app")
                    .imageScale(.small)
                    .foregroundStyle(.secondary)
            }
        }
    }
    struct withURLFooter: View {
        var body: some View {
            Section {
                🔗AppStoreLink()
            } footer: {
                Text(🔗AppStoreProductURL.description)
            }
        }
    }
}

struct 👤PrivacyPolicySection: View {
    var body: some View {
        Section {
            NavigationLink {
                Text(👤PrivacyPolicy)
                    .padding(32)
                    .textSelection(.enabled)
                    .navigationTitle("Privacy Policy")
            } label: {
                Label("Privacy Policy", systemImage: "person.text.rectangle")
            }
        }
    }
}

struct 📜VersionHistoryLink: View {
    var body: some View {
        Section {
            NavigationLink {
                List {
                    ForEach(📜VersionsInfo, id: \.self.ⓝumber) { 📜 in
                        Section {
                            Text(LocalizedStringKey(📜.ⓝumber), tableName: "🌏VersionDescription")
                                .font(.subheadline)
                                .padding()
                                .textSelection(.enabled)
                        } header: {
                            Text(📜.ⓝumber)
                        } footer: {
                            if 📜VersionsInfo.first?.ⓝumber == 📜.ⓝumber {
                                Text("builded on \(📜.ⓓate)")
                            } else {
                                Text("released on \(📜.ⓓate)")
                            }
                        }
                        .headerProminence(.increased)
                    }
                }
                .navigationBarTitle("Version History")
            } label: {
                Label("Version", systemImage: "signpost.left")
                    .badge(📜VersionsInfo.first?.ⓝumber ?? "🐛")
            }
            .accessibilityLabel("Version History")
        }
    }
}

struct 📓SourceCodeLink: View {
    var body: some View {
        NavigationLink {
            📓SourceCodeMenu()
        } label: {
            Label("Source code", systemImage: "doc.plaintext")
        }
    }
    struct 📓SourceCodeMenu: View {
        var body: some View {
            List {
                ForEach(📁SourceFolder.allCases) { 📁 in
                    📓CodeSection(📁.rawValue)
                }
                📑BundleMainInfoDictionary()
                🔗RepositoryLinks()
            }
            .navigationTitle("Source code")
        }
        struct 📓CodeSection: View {
            var ⓓirectoryPath: String
            var 📁URL: URL { Bundle.main.bundleURL.appendingPathComponent(ⓓirectoryPath) }
            var 🏷FileNames: [String]? { try? FileManager.default.contentsOfDirectory(atPath: 📁URL.path) }
            var body: some View {
                Section {
                    if let 🏷FileNames {
                        ForEach(🏷FileNames, id: \.self) { 🏷 in
                            NavigationLink(🏷) {
                                let 📃 = try? String(contentsOf: 📁URL.appendingPathComponent(🏷))
                                📰SourceCodeView(📃 ?? "🐛Bug", 🏷)
                            }
                        }
                        if 🏷FileNames.isEmpty { Text("🐛Bug") }
                    }
                } header: {
                    Text(ⓓirectoryPath)
                        .textCase(.none)
                }
            }
            init(_ ⓓirectoryPath: String) {
                self.ⓓirectoryPath = ⓓirectoryPath
            }
            func 📰SourceCodeView(_ ⓣext: String, _ ⓣitle: String) -> some View {
                ScrollView {
                    ScrollView(.horizontal, showsIndicators: false) {
                        Text(ⓣext)
                            .padding()
                    }
                }
                .navigationBarTitle(LocalizedStringKey(ⓣitle))
                .navigationBarTitleDisplayMode(.inline)
                .font(.caption.monospaced())
                .textSelection(.enabled)
            }
        }
        func 📑BundleMainInfoDictionary() -> some View {
            Section {
                NavigationLink("Bundle.main.infoDictionary") {
                    ScrollView {
                        Text(Bundle.main.infoDictionary!.description)
                            .padding()
                    }
                    .navigationBarTitle("Bundle.main.infoDictionary")
                    .navigationBarTitleDisplayMode(.inline)
                    .textSelection(.enabled)
                }
            }
        }
        struct 🔗RepositoryLinks: View {
            var body: some View {
                Section {
                    Link(destination: 🔗WebRepositoryURL) {
                        HStack {
                            Label("Web Repository", systemImage: "link")
                            Spacer()
                            Image(systemName: "arrow.up.forward.app")
                                .imageScale(.small)
                                .foregroundStyle(.secondary)
                        }
                    }
                } footer: {
                    Text(🔗WebRepositoryURL.description)
                }
                Section {
                    Link(destination: 🔗WebRepositoryURL_Mirror) {
                        HStack {
                            Label("Web Repository", systemImage: "link")
                            Text("(Mirror)")
                                .font(.subheadline.bold())
                                .foregroundStyle(.secondary)
                            Spacer()
                            Image(systemName: "arrow.up.forward.app")
                                .imageScale(.small)
                                .foregroundStyle(.secondary)
                        }
                    }
                } footer: {
                    Text(🔗WebRepositoryURL_Mirror.description)
                }
            }
        }
    }
}

struct 🧑‍💻AboutDeveloperPublisherLink: View {
    var body: some View {
        NavigationLink {
            🧑‍💻AboutDeveloperPublisherMenu()
        } label: {
            Label("Developer / Publisher", systemImage: "person")
        }
    }
    struct 🧑‍💻AboutDeveloperPublisherMenu: View {
        var body: some View {
            List {
                Section {
                    Text("Individual")
                } header: {
                    Text("The System")
                }
                Section {
                    Text("山下 亮")
                    Text("やました りょう (ひらがな)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Text("Yamashita Ryo (alphabet)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                } header: {
                    Text("Name")
                } footer: {
                    Text("only one person")
                }
                Section {
                    Text("age")
                        .badge("about 28")
                    Text("country")
                        .badge("Japan")
                    Text("native language")
                        .badge("Japanese")
                } header: {
                    Text("identity / circumstance / background")
                } footer: {
                    Text("As of 2021")
                }
                📆TimelineSection()
                Section {
                    Image("Developer_Publisher")
                        .resizable()
                        .frame(width: 90, height: 90)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .padding()
                        .opacity(0.6)
                } header: {
                    Text("Image")
                } footer: {
                    Text("Taken on 2021-11")
                }
            }
            .navigationTitle("Developer / Publisher")
        }
        struct 📆TimelineSection: View {
            var 📃Text: [[String]] =
            [["2013-04","Finished from high school in Okayama Prefecture. Entranced into University-of-the-Ryukyus/faculty-of-engineering in Okinawa Prefecture."],
             ["2018-06","Final year as an undergraduate student. Developed an iOS application(FlipByBlink) as software for the purpose of research experiments."],
             ["2019-01","Released ebook reader app \"FlipByBlink\" ver 1.0 on AppStore. Special feature is to turn a page by slightly-longish-voluntary-blink."],
             ["2019-03","Graduated from University-of-the-Ryukyus."],
             ["2019-05","Released alarm clock app with taking a long time \"FadeInAlarm\" ver 1.0. First paid app."],
             ["2019-07","Migrated to Okayama Prefecture."],
             ["2021-12","Released FlipByBlink ver 3.0 for the first time in three years since ver 2.0."],
             ["2022-02","Released FadeInAlarm ver 2.0 for the first time in three years since ver 1.0."],
             ["2022-04","Released simple shogi board app \"PlainShogiBoard\" ver 1.0."],
             ["2022-05","Released body weight registration app \"TapWeight\" ver 1.0."],
             ["2022-06","Released body temperature registration app \"TapTemperature\" ver 1.0."],
             ["2022-06","Adopted In-App Purchase model for the first time on TapWeight ver 1.1.1"],
             ["2022-09","Released LockInNote and MemorizeWidget on iOS16 release occasion."]]
            var body: some View {
                Section {
                    ForEach(📃Text, id: \.self) { 📃 in
                        HStack {
                            Text(📃.first ?? "🐛")
                                .font(.caption2)
                                .padding(8)
                            Text(LocalizedStringKey(📃.last ?? "🐛"))
                                .font(.caption)
                        }
                    }
                } header: {
                    Text("Timeline")
                }
            }
        }
    }
}

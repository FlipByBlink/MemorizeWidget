import SwiftUI

struct ℹ️HelpWindows: Scene {
    var body: some Scene {
        Group {
            📰DescriptionWindow()
            👤PrivacyPolicyWindow()
            📜VersionHistoryWindow()
            📓SourceCodeWindow()
            🧑‍💻DeveloperPublisherWindow()
        }
        .commandsRemoved()
    }
}

private struct 📰DescriptionWindow: Scene {
    var body: some Scene {
        Window(.init("Description", tableName: "🌐AboutApp"), id: "Description") {
            ScrollView {
                Text("current", tableName: "🌐AppStoreDescription")
                    .padding(24)
            }
            .textSelection(.enabled)
            .frame(width: 600, height: 500)
        }
        .windowResizability(.contentSize)
    }
}

private struct 👤PrivacyPolicyWindow: Scene {
    var body: some Scene {
        Window(.init("Privacy Policy", tableName: "🌐AboutApp"), id: "PrivacyPolicy") {
            Text(🗒️StaticInfo.privacyPolicyDescription)
                .font(.title3)
                .padding(32)
                .textSelection(.enabled)
                .frame(width: 500, height: 400)
        }
        .windowResizability(.contentSize)
    }
}

private struct 📜VersionHistoryWindow: Scene {
    var body: some Scene {
        Window(.init("Version History", tableName: "🌐AboutApp"), id: "VersionHistory") {
            List {
                ForEach(🗒️StaticInfo.versionInfos, id: \.version) { ⓘnfo in
                    GroupBox(ⓘnfo.version) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(LocalizedStringKey(ⓘnfo.version), tableName: "🌐VersionHistory")
                                .font(.subheadline)
                                .textSelection(.enabled)
                            Group {
                                if 🗒️StaticInfo.versionInfos.first?.version == ⓘnfo.version {
                                    Text("builded on \(ⓘnfo.date)", tableName: "🌐AboutApp")
                                } else {
                                    Text("released on \(ⓘnfo.date)", tableName: "🌐AboutApp")
                                }
                            }
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        }
                        .padding()
                    }
                }
            }
            .frame(width: 350, height: 450)
        }
        .windowResizability(.contentSize)
    }
}

private struct 📓SourceCodeWindow: Scene {
    var body: some Scene {
        Window(.init("Source code", tableName: "🌐AboutApp"), id: "SourceCode") {
            NavigationSplitView {
                List {
                    ForEach(🗒️StaticInfo.SourceCodeCategory.allCases) { Self.CodeSection($0) }
                    Divider()
                    self.bundleMainInfoDictionary()
                    Divider()
                    self.repositoryLinks()
                }
                .navigationTitle(.init("Source code", tableName: "🌐AboutApp"))
                .frame(minWidth: 270)
            } detail: {
                Text("← Select file", tableName: "🌐AboutApp")
                    .foregroundStyle(.tertiary)
            }
            .frame(minWidth: 1100, minHeight: 600)
        }
        .windowResizability(.contentMinSize)
    }
    private struct CodeSection: View {
        private var category: 🗒️StaticInfo.SourceCodeCategory
        private var url: URL {
            Bundle.main.bundleURL.appendingPathComponent("Contents/Resources/📁SourceCode")
        }
        var body: some View {
            Section {
                ForEach(self.category.fileNames, id: \.self) { ⓕileName in
                    if let ⓒode = try? String(contentsOf: self.url.appendingPathComponent(ⓕileName)) {
                        NavigationLink(ⓕileName) { self.sourceCodeView(ⓒode, ⓕileName) }
                    } else {
                        Text(verbatim: "🐛")
                    }
                }
                if self.category.fileNames.isEmpty { Text(verbatim: "🐛") }
            } header: {
                Text(self.category.rawValue)
                    .textCase(.none)
            }
        }
        init(_ category: 🗒️StaticInfo.SourceCodeCategory) {
            self.category = category
        }
        private func sourceCodeView(_ ⓣext: String, _ ⓣitle: String) -> some View {
            ScrollView {
                ScrollView(.horizontal, showsIndicators: false) {
                    Text(ⓣext)
                        .monospaced()
                        .padding()
                }
            }
            .environment(\.layoutDirection, .leftToRight)
            .navigationTitle(LocalizedStringKey(ⓣitle))
            .textSelection(.enabled)
        }
    }
    private func bundleMainInfoDictionary() -> some View {
        NavigationLink("Bundle.main.infoDictionary" as String) {
            Form {
                if let ⓓictionary = Bundle.main.infoDictionary {
                    ForEach(ⓓictionary.map({$0.key}), id: \.self) {
                        LabeledContent($0, value: String(describing: ⓓictionary[$0] ?? "🐛"))
                    }
                }
            }
            .navigationTitle(.init(verbatim: "Bundle.main.infoDictionary"))
            .textSelection(.enabled)
        }
    }
    private func repositoryLinks() -> some View {
        NavigationLink {
            VStack {
                Spacer()
                Text("Git repository is public on GitHub.com", tableName: "🌐AboutApp")
                    .font(.title2.weight(.medium))
                Spacer()
                VStack {
                    Link(destination: 🗒️StaticInfo.webRepositoryURL) {
                        HStack {
                            Text("Web Repository", tableName: "🌐AboutApp")
                                .font(.title3)
                            Image(systemName: "arrow.up.forward.app")
                                .foregroundStyle(.secondary)
                        }
                    }
                    Text(verbatim: "\(🗒️StaticInfo.webRepositoryURL)")
                        .foregroundStyle(.secondary)
                        .font(.subheadline.italic())
                }
                Spacer()
                VStack {
                    Link(destination: 🗒️StaticInfo.webMirrorRepositoryURL) {
                        HStack {
                            Text("(Mirror)", tableName: "🌐AboutApp")
                            Image(systemName: "arrow.up.forward.app")
                        }
                        .foregroundStyle(.secondary)
                    }
                    Text(verbatim: "\(🗒️StaticInfo.webMirrorRepositoryURL)")
                        .foregroundStyle(.secondary)
                        .font(.subheadline.italic())
                }
                Spacer()
            }
            .navigationTitle(.init("Web Repository", tableName: "🌐AboutApp"))
        } label: {
            Label(String(localized: "Web Repository", table: "🌐AboutApp"),
                  systemImage: "link")
        }
    }
}

private struct 🧑‍💻DeveloperPublisherWindow: Scene {
    var body: some Scene {
        Window(.init("Developer / Publisher", tableName: "🌐AboutApp"), id: "DeveloperPublisher") {
            List {
                Section {
                    GroupBox {
                        LabeledContent {
                            Text("only one person", tableName: "🌐AboutApp")
                        } label: {
                            Text("Individual", tableName: "🌐AboutApp")
                        }
                        .padding(4)
                    }
                } header: {
                    Text("The System", tableName: "🌐AboutApp")
                }
                Section {
                    GroupBox {
                        LabeledContent("山下 亮" as String, value: "Yamashita Ryo")
                            .padding(4)
                    }
                } header: {
                    Text("Name", tableName: "🌐AboutApp")
                }
                Section {
                    GroupBox {
                        VStack {
                            LabeledContent {
                                Text("about 29", tableName: "🌐AboutApp")
                            } label: {
                                Text("age", tableName: "🌐AboutApp")
                            }
                            LabeledContent {
                                Text("Japan", tableName: "🌐AboutApp")
                            } label: {
                                Text("country", tableName: "🌐AboutApp")
                            }
                            LabeledContent {
                                Text("Japanese", tableName: "🌐AboutApp")
                            } label: {
                                Text("native language", tableName: "🌐AboutApp")
                            }
                            Text("As of 2023", tableName: "🌐AboutApp")
                                .font(.caption)
                                .foregroundStyle(.tertiary)
                        }
                        .padding(4)
                    }
                } header: {
                    Text("background", tableName: "🌐AboutApp")
                }
                Self.TimelineSection()
                Section {
                    VStack(spacing: 8) {
                        Image(.developerPublisher)
                            .resizable()
                            .frame(width: 90, height: 90)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .opacity(0.6)
                        Text("Taken on 2021-11", tableName: "🌐AboutApp")
                            .font(.caption)
                            .foregroundStyle(.tertiary)
                    }
                    .padding(12)
                } header: {
                    Text("Image", tableName: "🌐AboutApp")
                }
                Self.jobHuntSection()
            }
            .frame(width: 540, height: 540)
        }
        .windowResizability(.contentSize)
    }
    private struct TimelineSection: View {
        private static var values: [(date: String, description: String)] {
            [("2013-04", "Finished from high school in Okayama Prefecture. Entranced into University-of-the-Ryukyus/faculty-of-engineering in Okinawa Prefecture."),
             ("2018-06", "Final year as an undergraduate student. Developed an iOS application(FlipByBlink) as software for the purpose of research experiments."),
             ("2019-01", "Released ebook reader app \"FlipByBlink\" ver 1.0 on App Store. Special feature is to turn a page by slightly-longish-voluntary-blink."),
             ("2019-03", "Graduated from University-of-the-Ryukyus."),
             ("2019-05", "Released alarm clock app with taking a long time \"FadeInAlarm\" ver 1.0. First paid app."),
             ("2019-07", "Migrated to Okayama Prefecture."),
             ("2021-12", "Released FlipByBlink ver 3.0 for the first time in three years since ver 2.0."),
             ("2022-02", "Released FadeInAlarm ver 2.0 for the first time in three years since ver 1.0."),
             ("2022-04", "Released simple shogi board app \"PlainShogiBoard\" ver 1.0."),
             ("2022-05", "Released body weight registration app \"TapWeight\" ver 1.0."),
             ("2022-06", "Released body temperature registration app \"TapTemperature\" ver 1.0."),
             ("2022-06", "Adopted In-App Purchase model for the first time on TapWeight ver 1.1.1"),
             ("2022-09", "Released LockInNote and MemorizeWidget on iOS16 release occasion."),
             ("2023-02", "Released Apple Watch app version of \"TapTemperature\"."),
             ("2023-04", "Released Mac app version of \"MemorizeWidget\"."),
             ("2023-05", "Released Apple TV app version of \"PlainShogiBoard\".")]
        }
        var body: some View {
            Section {
                GroupBox {
                    Grid {
                        ForEach(Self.values, id: \.self.description) { ⓥalue in
                            GridRow {
                                Text(ⓥalue.date)
                                    .font(.subheadline)
                                    .padding(8)
                                Text(LocalizedStringKey(ⓥalue.description), tableName: "🌐AboutApp")
                                    .font(.subheadline)
                                    .gridCellAnchor(.leading)
                            }
                        }
                    }
                }
            } header: {
                Text("Timeline", tableName: "🌐AboutApp")
            }
        }
    }
    private static func jobHuntSection() -> some View {
        Section {
            VStack(spacing: 8) {
                Text("Job hunting now!", tableName: "🌐AboutApp")
                    .font(.headline.italic())
                Text("If you are interested in hiring or acquiring, please contact me.",
                     tableName: "🌐AboutApp")
                .font(.subheadline)
                Text(🗒️StaticInfo.contactAddress)
                    .textSelection(.enabled)
                    .italic()
                    .foregroundStyle(.secondary)
            }
            .padding(12)
            .frame(maxWidth: .infinity)
        }
    }
}

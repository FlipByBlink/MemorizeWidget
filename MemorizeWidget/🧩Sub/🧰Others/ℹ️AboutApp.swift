import SwiftUI

struct ℹ️AboutAppLink: View {
    var name: LocalizedStringKey
    var subtitle: LocalizedStringKey
    var body: some View {
        Section {
            self.ⓘconAndName()
            🔗AppStoreLink()
            NavigationLink  {
                ℹ️AboutAppMenu()
            } label: {
                Label("About App", systemImage: "doc")
            }
        }
    }
    private func ⓘconAndName() -> some View {
        GeometryReader { 📐 in
            VStack(spacing: 8) {
                Image("RoundedIcon")
                    .resizable()
                    .frame(width: 100, height: 100)
                VStack(spacing: 6) {
                    Text(self.name)
                        .font(.system(.headline, design: .rounded))
                        .tracking(1.5)
                        .opacity(0.75)
                    Text(self.subtitle)
                        .font(.footnote)
                        .fontWeight(.medium)
                        .foregroundStyle(.secondary)
                }
                .lineLimit(1)
                .minimumScaleFactor(0.1)
            }
            .padding(20)
            .frame(width: 📐.size.width)
        }
        .frame(height: 200)
    }
}

private struct ℹ️AboutAppMenu: View {
    var body: some View {
        List {
            📰AppStoreDescriptionSection()
            📜VersionHistoryLink()
            👤PrivacyPolicySection()
            🏬AppStoreSection()
            📓SourceCodeLink()
            🧑‍💻AboutDeveloperPublisherLink()
        }
        .navigationTitle("About App")
    }
}

private struct 📰AppStoreDescriptionSection: View {
    var body: some View {
        Section {
            NavigationLink {
                ScrollView {
                    Text("AppStoreDescription", tableName: "🌏AppStoreDescription")
                        .padding()
                }
                .navigationBarTitle("Description")
                .textSelection(.enabled)
            } label: {
                Text(self.ⓛabelString)
                    .font(.subheadline)
                    .lineSpacing(5)
                    .lineLimit(7)
                    .padding(8)
                    .accessibilityLabel("Description")
            }
        } header: {
            Text("Description")
        }
    }
    private var ⓛabelString: String {
        String(localized: "AppStoreDescription", table: "🌏AppStoreDescription")
            .replacingOccurrences(of: "\n\n", with: "\n")
            .replacingOccurrences(of: "\n\n", with: "\n")
    }
}

private struct 🔗AppStoreLink: View {
    @Environment(\.openURL) var openURL
    var body: some View {
        Button {
            self.openURL(🔗appStoreProductURL)
        } label: {
            HStack {
                Label("Open AppStore page", systemImage: "link")
                Spacer()
                Image(systemName: "arrow.up.forward.app")
                    .font(.body.weight(.light))
                    .imageScale(.small)
            }
        }
    }
}

private struct 🏬AppStoreSection: View {
    @Environment(\.openURL) var openURL
    var body: some View {
        Section {
            🔗AppStoreLink()
            Button {
                let ⓤrl = URL(string: 🔗appStoreProductURL.description + "?action=write-review")!
                self.openURL(ⓤrl)
            } label: {
                HStack {
                    Label("Review on AppStore", systemImage: "star.bubble")
                    Spacer()
                    Image(systemName: "arrow.up.forward.app")
                        .imageScale(.small)
                        .foregroundStyle(.secondary)
                }
            }
        } footer: {
            Text(🔗appStoreProductURL.description)
        }
    }
}

private struct 👤PrivacyPolicySection: View {
    var body: some View {
        Section {
            NavigationLink {
                ScrollView {
                    Text(👤privacyPolicyDescription)
                        .padding(24)
                        .textSelection(.enabled)
                }
                .navigationTitle("Privacy Policy")
            } label: {
                Label("Privacy Policy", systemImage: "person.text.rectangle")
            }
        }
    }
}

struct 📜VersionInfo: Identifiable {
    var number: String
    var date: String
    var id: String { self.number }
    static func history(_ ⓘnfos: (ⓝumber: String, ⓓate: String) ...) -> [Self] {
        ⓘnfos.map { Self(number: $0.ⓝumber, date: $0.ⓓate) }
    }
}

private struct 📜VersionHistoryLink: View {
    var body: some View {
        Section {
            NavigationLink {
                List {
                    ForEach(📜versionInfos) { ⓥersion in
                        Section {
                            Text(LocalizedStringKey(ⓥersion.number), tableName: "🌏VersionDescription")
                                .font(.subheadline)
                                .padding()
                                .textSelection(.enabled)
                        } header: {
                            Text(ⓥersion.number)
                        } footer: {
                            if 📜versionInfos.first?.number == ⓥersion.number {
                                Text("builded on \(ⓥersion.date)")
                            } else {
                                Text("released on \(ⓥersion.date)")
                            }
                        }
                        .headerProminence(.increased)
                    }
                }
                .navigationBarTitle("Version History")
            } label: {
                Label("Version", systemImage: "signpost.left")
                    .badge(📜versionInfos.first?.number ?? "🐛")
            }
            .accessibilityLabel("Version History")
        }
    }
}

private struct 📓SourceCodeLink: View {
    var body: some View {
        NavigationLink {
            self.ⓢourceCodeMenu()
        } label: {
            Label("Source code", systemImage: "doc.plaintext")
        }
    }
    private func ⓢourceCodeMenu() -> some View {
        List {
            ForEach(📁SourceCodeCategory.allCases) {
                Self.📓CodeSection($0)
            }
            self.📑bundleMainInfoDictionary()
            self.🔗repositoryLinks()
        }
        .navigationTitle("Source code")
    }
    private struct 📓CodeSection: View {
        private var ⓒategory: 📁SourceCodeCategory
        private var 🔗url: URL {
#if targetEnvironment(macCatalyst)
            Bundle.main.bundleURL.appendingPathComponent("Contents/Resources/📁SourceCode")
#else
            Bundle.main.bundleURL.appendingPathComponent("📁SourceCode")
#endif
        }
        var body: some View {
            Section {
                ForEach(self.ⓒategory.fileNames, id: \.self) { ⓝame in
                    if let ⓒode = try? String(contentsOf: self.🔗url.appendingPathComponent(ⓝame)) {
                        NavigationLink(ⓝame) {
                            self.📰sourceCodeView(ⓒode, ⓝame)
                        }
                    } else {
                        Text("🐛")
                    }
                }
                if self.ⓒategory.fileNames.isEmpty { Text("🐛") }
            } header: {
                Text(self.ⓒategory.rawValue)
                    .textCase(.none)
            }
        }
        init(_ category: 📁SourceCodeCategory) {
            self.ⓒategory = category
        }
        private func 📰sourceCodeView(_ ⓣext: String, _ ⓣitle: String) -> some View {
            ScrollView {
                ScrollView(.horizontal, showsIndicators: false) {
                    Text(ⓣext)
                        .padding()
                }
            }
            .navigationBarTitle(LocalizedStringKey(ⓣitle))
            .font(.caption.monospaced())
            .textSelection(.enabled)
        }
    }
    private func 📑bundleMainInfoDictionary() -> some View {
        Section {
            NavigationLink("Bundle.main.infoDictionary") {
                ScrollView {
                    Text(Bundle.main.infoDictionary!.description)
                        .padding()
                }
                .navigationBarTitle("Bundle.main.infoDictionary")
                .textSelection(.enabled)
            }
        }
    }
    private func 🔗repositoryLinks() -> some View {
        Group {
            Section {
                Link(destination: 🔗webRepositoryURL) {
                    HStack {
                        Label("Web Repository", systemImage: "link")
                        Spacer()
                        Image(systemName: "arrow.up.forward.app")
                            .imageScale(.small)
                            .foregroundStyle(.secondary)
                    }
                }
            } footer: {
                Text(🔗webRepositoryURL.description)
            }
            Section {
                Link(destination: 🔗webMirrorRepositoryURL) {
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
                Text(🔗webMirrorRepositoryURL.description)
            }
        }
    }
}

private struct 🧑‍💻AboutDeveloperPublisherLink: View {
    var body: some View {
        NavigationLink {
            self.ⓐboutDeveloperPublisherMenu()
        } label: {
            Label("Developer / Publisher", systemImage: "person")
        }
    }
    private func ⓐboutDeveloperPublisherMenu() -> some View {
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
            Self.📆TimelineSection()
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
    private struct 📆TimelineSection: View {
        private var 📃text: [[String]] =
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
                ForEach(📃text, id: \.self) { 📃 in
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

struct 💬PrepareToRequestUserReview: ViewModifier {
    @Binding private var ⓒheckToRequest: Bool
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content
                .modifier(ⓜodifier(self.$ⓒheckToRequest))
        } else {
            content
        }
    }
    init(_ checkToRequest: Binding<Bool>) {
        self._ⓒheckToRequest = checkToRequest
    }
    @available(iOS 16, *)
    private struct ⓜodifier: ViewModifier {
        @Environment(\.requestReview) var requestReview
        @AppStorage("launchCount") private var ⓛaunchCount: Int = 0
        @Binding private var ⓒheckToRequest: Bool
        func body(content: Content) -> some View {
            content
                .task { self.ⓛaunchCount += 1 }
                .onChange(of: self.ⓒheckToRequest) {
                    if $0 == true {
                        if [10, 30, 50, 70, 90].contains(self.ⓛaunchCount) {
                            self.requestReview()
                        }
                    }
                }
        }
        init(_ checkToRequest: Binding<Bool>) {
            self._ⓒheckToRequest = checkToRequest
        }
    }
}


let 📜VersionNumber = "1.1"

let 📜PastVersions: [(ⓝumber: String, ⓓate: String)] = [("1.0.2", "2022-09-16"),
                                                        ("1.0.1", "2022-09-11"),
                                                        ("1.0", "2022-09-09")]


import SwiftUI

struct 📜VersionHistoryLink: View {
    var body: some View {
        Section {
            NavigationLink {
                List {
                    Section {
                        Text(LocalizedStringKey(📜VersionNumber), tableName: "🌏VersionDescription")
                            .font(.subheadline)
                            .padding()
                    } header: {
                        Text(📜VersionNumber)
                    } footer: {
                        let 📅 = Date.now.formatted(date: .long, time: .omitted)
                        Text("builded on \(📅)")
                    }
                    .headerProminence(.increased)
                    
                    
                    📜PastVersionSection()
                }
                .navigationBarTitle("Version History")
                .textSelection(.enabled)
            } label: {
                Label("Version", systemImage: "signpost.left")
                    .badge(📜VersionNumber)
            }
            .accessibilityLabel("Version History")
        }
    }
}

struct 📜PastVersionSection: View {
    var body: some View {
        ForEach(📜PastVersions, id: \.self.ⓝumber) { 📜 in
            Section {
                Text(LocalizedStringKey(📜.ⓝumber), tableName: "🌏VersionDescription")
                    .font(.subheadline)
                    .padding()
            } header: {
                Text(📜.ⓝumber)
            } footer: {
                Text(📜.ⓓate)
            }
            .headerProminence(.increased)
        }
    }
}

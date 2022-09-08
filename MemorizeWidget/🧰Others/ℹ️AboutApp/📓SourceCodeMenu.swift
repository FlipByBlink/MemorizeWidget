
let 🔗WebRepositoryURL = URL(string: "https://github.com/FlipByBlink/MemorizeWidget")!
let 🔗WebRepositoryURL_Mirror = URL(string: "https://gitlab.com/FlipByBlink/MemorizeWidget_Mirror")!


import SwiftUI

enum 📁SourceFolder: String, CaseIterable, Identifiable {
    case main
    case 🧩Sub
    case ℹ️AboutApp
    case 📣AD
    case 🛒InAppPurchase
    
    var id: String { self.rawValue }
}

struct 📓SourceCodeLink: View {
    var body: some View {
        NavigationLink {
            📓SourceCodeMenu()
        } label: {
            Label("Source code", systemImage: "doc.plaintext")
        }
    }
}

struct 📓SourceCodeMenu: View {
    var body: some View {
        List {
            ForEach(📁SourceFolder.allCases) { 📁 in
                📓CodeSection(📁.rawValue)
            }
            
            📑BundleMainInfoDictionary()
            🔗RepositoryLink()
        }
        .navigationTitle("Source code")
    }
}

struct 📓CodeSection: View {
    var 🄳irectoryPath: String
    var 📁URL: URL { Bundle.main.bundleURL.appendingPathComponent(🄳irectoryPath) }
    var 🏷FileName: [String] {
        do {
            return try FileManager.default.contentsOfDirectory(atPath: 📁URL.path)
        } catch { return [] }
    }
    
    var body: some View {
        Section {
            ForEach(🏷FileName, id: \.self) { 🏷 in
                NavigationLink(🏷) {
                    let 📃 = try? String(contentsOf: 📁URL.appendingPathComponent(🏷))
                    📰SourceCodeView(📃 ?? "🐛Bug", 🏷)
                }
            }
            
            if 🏷FileName.isEmpty { Text("🐛Bug") }
        } header: {
            Text(🄳irectoryPath)
                .textCase(.none)
        }
    }
    
    init(_ ⓓirectoryPath: String) {
        🄳irectoryPath = ⓓirectoryPath
    }
}


let 🄱undleMainInfoDictionary = Bundle.main.infoDictionary!.description
struct 📑BundleMainInfoDictionary: View {
    var body: some View {
        Section {
            NavigationLink("Bundle.main.infoDictionary") {
                ScrollView {
                    Text(🄱undleMainInfoDictionary)
                        .padding()
                }
                .navigationBarTitle("Bundle.main.infoDictionary")
                .navigationBarTitleDisplayMode(.inline)
                .textSelection(.enabled)
            }
        }
    }
}


struct 🔗RepositoryLink: View {
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
        } footer: { Text(🔗WebRepositoryURL.description) }
        
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
        } footer: { Text(🔗WebRepositoryURL_Mirror.description) }
    }
}


struct 📰SourceCodeView: View {
    var 🅃ext: String
    var 🅃itle: LocalizedStringKey
    
    var body: some View {
        ScrollView {
            ScrollView(.horizontal, showsIndicators: false) {
                Text(🅃ext)
                    .padding()
            }
        }
        .navigationBarTitle(🅃itle)
        .navigationBarTitleDisplayMode(.inline)
        .font(.caption.monospaced())
        .textSelection(.enabled)
    }
    
    init(_ ⓣext: String, _ ⓣitle: String) {
        🅃ext = ⓣext
        🅃itle = LocalizedStringKey(ⓣitle)
    }
}

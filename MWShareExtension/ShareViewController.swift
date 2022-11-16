import UIKit
import Social
import MobileCoreServices
import UniformTypeIdentifiers
import SwiftUI

class 🄷ostingController: UIHostingController<🄼ainView> {
    let ⓜodel = 🄳ataModel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: 🄼ainView(ⓜodel))
    }
    
    override func viewDidLoad() {
        ⓜodel.extensionContext = extensionContext
        if let ⓘtem = extensionContext?.inputItems.first as? NSExtensionItem {
            if let ⓟrovider = ⓘtem.attachments?.first {
                if ⓟrovider.registeredTypeIdentifiers.contains("public.file-url") {
                    ⓜodel.type = .textFile
                    Task { @MainActor in
                        do {
                            if let ⓤrl = try await ⓟrovider.loadItem(forTypeIdentifier: "public.file-url") as? URL {
                                let ⓓata = try Data(contentsOf: ⓤrl)
                                ⓜodel.importedText = String(data: ⓓata, encoding: .utf8) ?? "テキストファイルではありません。"
                            }
                        } catch {
                            print("🚨:", error.localizedDescription)
                        }
                    }
                } else {
                    ⓜodel.type = .selectedText
                    Task { @MainActor in
                        do {
                            if let ⓢtring = try await ⓟrovider.loadItem(forTypeIdentifier: "public.plain-text") as? String {
                                ⓜodel.inputTitle = ⓢtring
                            }
                        } catch {
                            print("🚨:", error.localizedDescription)
                        }
                    }
                }
            }
        }
    }
}

class 🄳ataModel: ObservableObject {
    var extensionContext: NSExtensionContext? = nil
    @Published var importedText: String = "🐛"
    var type: 🅃ype = .selectedText
    @Published var inputTitle: String = "🐛"
    @Published var inputComment: String = ""
}

enum 🅃ype {
    case textFile, selectedText
}

struct 🄼ainView: View {
    @ObservedObject var ⓜodel: 🄳ataModel
    static let ⓤd = UserDefaults(suiteName: "group.net.aaaakkkkssssttttnnnn.MemorizeWidget")
    @AppStorage("separator", store: ⓤd) var ⓢeparator: 🅂eparator = .tab
    //@AppStorage("sharedText", store: ⓤd) var sharedText = "empty"
    
    var body: some View {
        NavigationStack {
            List {
                switch ⓜodel.type {
                    case .textFile:
                        🅂eparatorPicker()
                        ForEach(ⓜodel.importedText.components(separatedBy: .newlines), id: \.self) { line in
                            Text(line)
                        }
                    case .selectedText:
                        TextField("Title", text: $ⓜodel.inputTitle)
                        TextField("Comment", text: $ⓜodel.inputComment)
                            .foregroundStyle(.secondary)
                }
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        print("Pressed checkmark button")
                        ⓜodel.extensionContext?.completeRequest(returningItems: nil)
                    } label: {
                        Image(systemName: "checkmark")
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        print("Pressed xmark button")
                        ⓜodel.extensionContext?.completeRequest(returningItems: nil)
                    } label: {
                        Image(systemName: "xmark")
                    }
                    .tint(.red)
                }
            }
        }
    }
    func 🅂eparatorPicker() -> some View {
        Section {
            Picker(selection: $ⓢeparator) {
                Text("Tab ␣ ").tag(🅂eparator.tab)
                    .accessibilityLabel("Tab")
                Text("Comma , ").tag(🅂eparator.comma)
                    .accessibilityLabel("Comma")
                Text("(Title only)").tag(🅂eparator.titleOnly)
                    .accessibilityLabel("Title only")
            } label: {
                Label("Separator", systemImage: "arrowtriangle.left.and.line.vertical.and.arrowtriangle.right")
            }
        }
    }
    init(_ ⓜodel: 🄳ataModel) {
        self.ⓜodel = ⓜodel
    }
}

enum 🅂eparator: String {
    case tab = "\t"
    case comma = ","
    case titleOnly = ""
}

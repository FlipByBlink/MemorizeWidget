import UIKit
import Social
import MobileCoreServices
import UniformTypeIdentifiers
import SwiftUI

class 🄷ostingController: UIHostingController<🄼ainView> {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: 🄼ainView())
    }
    
    override func viewDidLoad() {
        rootView.extensionContext = extensionContext
        if let ⓘtem = extensionContext?.inputItems.first as? NSExtensionItem {
            if let ⓟrovider = ⓘtem.attachments?.first {
                if ⓟrovider.registeredTypeIdentifiers.contains("public.file-url") {
                    rootView.ⓣype = .textFile
                    Task { @MainActor in
                        do {
                            if let ⓤrl = try await ⓟrovider.loadItem(forTypeIdentifier: "public.file-url") as? URL {
                                let ⓓata = try Data(contentsOf: ⓤrl)
                                rootView.ⓘmportedText = String(data: ⓓata, encoding: .utf8) ?? "テキストファイルではありません。"
                            }
                        } catch {
                            print("🚨:", error.localizedDescription)
                        }
                    }
                } else {
                    rootView.ⓣype = .selectedText
                    Task { @MainActor in
                        do {
                            if let ⓢtring = try await ⓟrovider.loadItem(forTypeIdentifier: "public.plain-text") as? String {
                                rootView.ⓘmportedText = ⓢtring
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

enum 🅃ype {
    case textFile, selectedText
}

struct 🄼ainView: View {
    var extensionContext: NSExtensionContext? = nil
    static let ⓤd = UserDefaults(suiteName: "group.net.aaaakkkkssssttttnnnn.MemorizeWidget")
    @AppStorage("separator", store: ⓤd) var ⓢeparator: 🅂eparator = .tab
    //@AppStorage("sharedText", store: ⓤd) var sharedText = "empty"
    var ⓘmportedText: String = "🐛importedText"
    var ⓣype: 🅃ype = .selectedText
    @State private var ⓘnputTitle: String = "🐛title"
    @State private var ⓘnputComment: String = ""
    
    var body: some View {
        NavigationStack {
            List {
                switch ⓣype {
                    case .textFile:
                        🅂eparatorPicker()
                        ForEach(ⓘmportedText.components(separatedBy: .newlines), id: \.self) { line in
                            Text(line)
                        }
                    case .selectedText:
                        TextField("Title", text: $ⓘnputTitle)
                            .onChange(of: ⓘmportedText) { newValue in
                                ⓘnputTitle = newValue
                            }
                        TextField("Comment", text: $ⓘnputComment)
                            .foregroundStyle(.secondary)
                }
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        print("Pressed checkmark button")
                        extensionContext?.completeRequest(returningItems: nil)
                    } label: {
                        Image(systemName: "checkmark")
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        print("Pressed xmark button")
                        extensionContext?.completeRequest(returningItems: nil)
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
}

enum 🅂eparator: String {
    case tab = "\t"
    case comma = ","
    case titleOnly = ""
}

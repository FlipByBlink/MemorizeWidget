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
                    Task { @MainActor in
                        do {
                            if let ⓤrl = try await ⓟrovider.loadItem(forTypeIdentifier: "public.file-url") as? URL {
                                let ⓓata = try Data(contentsOf: ⓤrl)
                                if let ⓢtring = String(data: ⓓata, encoding: .utf8) {
                                    ⓜodel.type = .textFile
                                    ⓜodel.importedText = ⓢtring
                                } else {
                                    ⓜodel.type = .improperFile
                                }
                            }
                        } catch {
                            print("🚨:", error.localizedDescription)
                        }
                    }
                } else {
                    Task { @MainActor in
                        do {
                            if let ⓢtring = try await ⓟrovider.loadItem(forTypeIdentifier: "public.plain-text") as? String {
                                ⓜodel.type = .selectedText
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
    @Published var type: 🅃ype? = nil
    @Published var importedText: String = ""
    @Published var inputTitle: String = ""
    @Published var inputComment: String = ""
}

struct 🄼ainView: View {
    @ObservedObject var ⓜodel: 🄳ataModel
    static let ⓤd = UserDefaults(suiteName: "group.net.aaaakkkkssssttttnnnn.MemorizeWidget")
    @AppStorage("separator", store: ⓤd) var ⓢeparator: 🅂eparator = .tab
    //@AppStorage("sharedText", store: ⓤd) var sharedText = "empty"
    var ⓝotes: [📓Note] { 🄲onvertTextToNotes(ⓜodel.importedText, ⓢeparator) }
    
    var body: some View {
        NavigationStack {
            List {
                switch ⓜodel.type {
                    case .textFile:
                        🅂eparatorPicker()
                        ForEach(ⓝotes) { ⓝote in
                            VStack(alignment: .leading) {
                                Text(ⓝote.title)
                                Text(ⓝote.comment)
                                    .font(.footnote)
                                    .foregroundStyle(.secondary)
                            }
                            .padding(.vertical, 8)
                        }
                    case .improperFile:
                        Label("Not text file.", systemImage: "exclamationmark.triangle")
                            .foregroundStyle(.secondary)
                    case .selectedText:
                        TextField("Title", text: $ⓜodel.inputTitle)
                        TextField("Comment", text: $ⓜodel.inputComment)
                            .foregroundStyle(.secondary)
                    case .none:
                        Text("🐛")
                }
            }
            .toolbar {
                if ⓜodel.type != .improperFile {
                    ToolbarItem {
                        Button {//TODO: 実装
                            print("Pressed checkmark button")
                            switch ⓜodel.type {
                                case .textFile:
                                    📚NotesFromExtension().save(notes: ⓝotes)
                                case .selectedText:
                                    📚NotesFromExtension().save(notes: [📓Note(ⓜodel.inputTitle, ⓜodel.inputComment)])
                                default:
                                    📚NotesFromExtension().save(notes: [📓Note("🐛")])
                            }
                            ⓜodel.extensionContext?.completeRequest(returningItems: nil)
                        } label: {
                            Image(systemName: "checkmark")
                        }
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
        .animation(.default, value: ⓢeparator)
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

enum 🅃ype {
    case textFile, improperFile, selectedText
}

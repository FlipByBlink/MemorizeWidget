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
        if let ⓔxtensionItem = extensionContext?.inputItems.first as? NSExtensionItem {
            if let ⓟrovider = ⓔxtensionItem.attachments?.first {
                if ⓟrovider.hasItemConformingToTypeIdentifier("public.file-url") {
                    Task { @MainActor in
                        do {
                            if let ⓤrl = try await ⓟrovider.loadItem(forTypeIdentifier: "public.file-url") as? URL {
                                ⓜodel.importedText = try String(contentsOf: ⓤrl)
                                ⓜodel.type = .textFile
                            }
                        } catch {
                            print("🚨:", error)
                            ⓜodel.type = .improperFile
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
                            print("🚨:", error)
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
    @AppStorage("separator", store: UserDefaults(suiteName: 🆔AppGroupID)) var separator: 🅂eparator = .tab
    var convertedNotes: [📗Note] { 🄲onvertTextToNotes(importedText, separator) }
    func storeNotes() {
        var ⓝotes = 💾DataManager.load() ?? []
        switch type {
            case .textFile:
                ⓝotes.insert(contentsOf: convertedNotes, at: 0)
                💾DataManager.save(ⓝotes)
            case .selectedText:
                ⓝotes.insert(contentsOf: [📗Note(inputTitle, inputComment)], at: 0)
                💾DataManager.save(ⓝotes)
            default:
                💾DataManager.save([📗Note("🐛")])
        }
        💾DataManager.save(ⓝotes)
    }
}

struct 🄼ainView: View {
    @ObservedObject var ⓜodel: 🄳ataModel
    var body: some View {
        NavigationView {
            List {
                switch ⓜodel.type {
                    case .textFile:
                        🅂eparatorPicker()
                        ForEach(ⓜodel.convertedNotes) { ⓝote in
                            VStack(alignment: .leading) {
                                Text(ⓝote.title)
                                Text(ⓝote.comment)
                                    .font(.footnote)
                                    .foregroundStyle(.secondary)
                            }
                            .padding(.vertical, 8)
                        }
                    case .improperFile:
                        Label("Not text file(UTF-8).", systemImage: "exclamationmark.triangle")
                            .foregroundStyle(.secondary)
                    case .selectedText:
                        TextField("No title", text: $ⓜodel.inputTitle)
                        TextField("No comment", text: $ⓜodel.inputComment)
                            .foregroundStyle(.secondary)
                    case .none:
                        Text("🐛")
                }
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        UINotificationFeedbackGenerator().notificationOccurred(.success)
                        ⓜodel.storeNotes()
                        ⓜodel.extensionContext?.completeRequest(returningItems: nil)
                    } label: {
                        Image(systemName: "checkmark")
                    }
                    .disabled(ⓜodel.type == .improperFile)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        UINotificationFeedbackGenerator().notificationOccurred(.warning)
                        ⓜodel.extensionContext?.completeRequest(returningItems: nil)
                    } label: {
                        Image(systemName: "xmark")
                    }
                    .tint(.red)
                }
            }
        }
        .animation(.default, value: ⓜodel.separator)
        .navigationViewStyle(.stack)
    }
    func 🅂eparatorPicker() -> some View {
        Section {
            Picker(selection: $ⓜodel.separator) {
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

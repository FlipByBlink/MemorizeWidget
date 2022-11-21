import UIKit
import Social
import MobileCoreServices
import UniformTypeIdentifiers
import SwiftUI

class 📨ShareExtensionModel: ObservableObject {
    var extensionContext: NSExtensionContext? = nil
    @Published var type: 🅃ype? = nil
    @Published var importedText: String = ""
    @Published var inputTitle: String = ""
    @Published var inputComment: String = ""
    @AppStorage("separator", store: UserDefaults(suiteName: 🆔AppGroupID)) var separator: 🅂eparator = .tab
    var convertedNotes: [📗Note] { 🄲onvertTextToNotes(self.importedText, self.separator) }
    func storeNotes() {
        var ⓝotes = 💾DataManager.load() ?? []
        switch self.type {
            case .textFile:
                ⓝotes.insert(contentsOf: self.convertedNotes, at: 0)
                💾DataManager.save(ⓝotes)
            case .selectedText:
                ⓝotes.insert(contentsOf: [📗Note(self.inputTitle, self.inputComment)], at: 0)
                💾DataManager.save(ⓝotes)
            default:
                💾DataManager.save([📗Note("🐛")])
        }
        💾DataManager.save(ⓝotes)
    }
    @MainActor
    func setUp(_ extensionContext: NSExtensionContext?) {
        self.extensionContext = extensionContext
        if let ⓔxtensionItem = self.extensionContext?.inputItems.first as? NSExtensionItem {
            if let ⓟrovider = ⓔxtensionItem.attachments?.first {
                if ⓟrovider.hasItemConformingToTypeIdentifier("public.file-url") {
                    Task { @MainActor in
                        do {
                            if let ⓤrl = try await ⓟrovider.loadItem(forTypeIdentifier: "public.file-url") as? URL {
                                self.importedText = try String(contentsOf: ⓤrl)
                                self.type = .textFile
                            }
                        } catch {
                            print("🚨:", error)
                            self.type = .improperFile
                        }
                    }
                } else {
                    Task { @MainActor in
                        do {
                            if let ⓢtring = try await ⓟrovider.loadItem(forTypeIdentifier: "public.plain-text") as? String {
                                self.type = .selectedText
                                self.inputTitle = ⓢtring
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

enum 🅃ype {
    case textFile, selectedText, improperFile
}

class 🄷ostingController: UIHostingController<🄼ainView> {
    let 📨 = 📨ShareExtensionModel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: 🄼ainView(📨))
    }
    
    override func viewDidLoad() {
        📨.setUp(extensionContext)
    }
}

struct 🄼ainView: View {
    @ObservedObject var 📨: 📨ShareExtensionModel
    var body: some View {
        NavigationView {
            List {
                switch 📨.type {
                    case .textFile:
                        🅂eparatorPicker()
                        ForEach(📨.convertedNotes) { ⓝote in
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
                        TextField("No title", text: $📨.inputTitle)
                        TextField("No comment", text: $📨.inputComment)
                            .foregroundStyle(.secondary)
                    case .none:
                        Text("🐛")
                }
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        UINotificationFeedbackGenerator().notificationOccurred(.success)
                        📨.storeNotes()
                        📨.extensionContext?.completeRequest(returningItems: nil)
                    } label: {
                        Image(systemName: "checkmark")
                    }
                    .disabled(📨.type == .improperFile)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        UINotificationFeedbackGenerator().notificationOccurred(.warning)
                        📨.extensionContext?.completeRequest(returningItems: nil)
                    } label: {
                        Image(systemName: "xmark")
                    }
                    .tint(.red)
                }
            }
        }
        .animation(.default, value: 📨.separator)
        .navigationViewStyle(.stack)
    }
    func 🅂eparatorPicker() -> some View {
        Section {
            Picker(selection: $📨.separator) {
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
    init(_ 📨: 📨ShareExtensionModel) {
        self.📨 = 📨
    }
}

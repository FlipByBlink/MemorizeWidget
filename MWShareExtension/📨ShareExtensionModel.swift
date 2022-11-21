import SwiftUI

class 📨ShareExtensionModel: ObservableObject {
    var extensionContext: NSExtensionContext? = nil
    @Published var type: 🅃ype? = nil
    @Published var importedText: String = "" //TODO: リファクタリング
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

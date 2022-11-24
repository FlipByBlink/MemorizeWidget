import SwiftUI

class 📨ShareExtensionModel: ObservableObject {
    var extensionContext: NSExtensionContext? = nil
    @Published var type: 🅃ype? = nil
    @Published var importedText: String = "" //TODO: リファクタリング
    @Published var singleNote = 📗Note("")
    @AppStorage("separator", store: UserDefaults(suiteName: 🆔AppGroupID)) var separator: 🅂eparator = .tab
    var convertedNotes: [📗Note] { 🄲onvertTextToNotes(self.importedText, self.separator) }
    func storeNotes() {
        var ⓝotes = 💾DataManager.notes ?? []
        switch self.type {
            case .textFile:
                ⓝotes.insert(contentsOf: self.convertedNotes, at: 0)
            case .selectedText:
                ⓝotes.insert(contentsOf: [self.singleNote], at: 0)
            default:
                ⓝotes.insert(contentsOf: [📗Note("🐛")], at: 0)
        }
        💾DataManager.save(ⓝotes)
        UserDefaults(suiteName: 🆔AppGroupID)?.set(true, forKey: "savedDataByShareExtension")
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
                                self.singleNote.title = ⓢtring
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

import SwiftUI

class 📨ShareExtensionModel: ObservableObject {
    var extensionContext: NSExtensionContext? = nil
    
    @AppStorage("separator", store: 💾AppGroupUD) var separator: 🅂eparator = .tab
    @Published var type: 🅃ype? = nil
    
    @Published var importedFileText: String = ""
    
    @Published var singleNote = 📗Note("")
    @Published var importSelectedTextAsSingleNote: Bool = true
    
    var convertedNotes: 📚Notes {
        switch self.type {
            case .textFile: return .convert(self.importedFileText, self.separator)
            case .selectedText: return .convert(self.singleNote.title, self.separator)
            default: return []
        }
    }
    
    func storeNotes() {
        var ⓝotes: 📚Notes = .load() ?? []
        switch self.type {
            case .textFile:
                ⓝotes.insert(contentsOf: self.convertedNotes, at: 0)
            case .selectedText:
                if self.importSelectedTextAsSingleNote {
                    ⓝotes.insert(contentsOf: [self.singleNote], at: 0)
                } else {
                    ⓝotes.insert(contentsOf: self.convertedNotes, at: 0)
                }
            default:
                ⓝotes.insert(contentsOf: [📗Note("🐛")], at: 0)
        }
        ⓝotes.save()
        💾AppGroupUD?.set(true, forKey: "savedDataByShareExtension")
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
                                self.importedFileText = try String(contentsOf: ⓤrl)
                                self.type = .textFile
                            }
                        } catch {
                            print("🚨", error)
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
                            print("🚨", error)
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

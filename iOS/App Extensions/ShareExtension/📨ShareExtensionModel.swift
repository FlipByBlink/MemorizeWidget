import SwiftUI

class 📨ShareExtensionModel: ObservableObject {
    var extensionContext: NSExtensionContext? = nil
    @AppStorage("separator", store: .ⓐppGroup) var separator: 📚TextConvert.Separator = .tab
    @Published var type: 📨InputType? = nil
    @Published var importedFileText: String = ""
    @Published var singleNote: 📗Note = .empty
    @Published var importSelectedTextAsSingleNote: Bool = true
}

extension 📨ShareExtensionModel {
    var convertedNotes: 📚Notes {
        switch self.type {
            case .textFile: 📚TextConvert.decode(self.importedFileText, self.separator)
            case .selectedText: 📚TextConvert.decode(self.singleNote.title, self.separator)
            default: []
        }
    }
    func storeNotes() {
        var ⓝotes: 📚Notes = 💾ICloud.loadNotes() ?? []
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
                ⓝotes.insert(contentsOf: [📗Note("BUG")], at: 0)
        }
        💾ICloud.save(ⓝotes)
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
                                let ⓣext = try String(contentsOf: ⓤrl)
                                let ⓓataCount = 📚TextConvert.decode(ⓣext, self.separator).dataCount
                                let ⓐctiveNotes = 💾ICloud.loadNotes() ?? []
                                guard (ⓓataCount + ⓐctiveNotes.dataCount) < 800000 else {
                                    self.type = .exceedDataLimitation
                                    return
                                }
                                self.importedFileText = ⓣext
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

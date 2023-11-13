import SwiftUI

@MainActor
class 📥NotesImportModel: ObservableObject {
    @AppStorage("InputMode", store: .ⓐppGroup) var inputMode: 📥InputMode = .file
    @AppStorage("separator", store: .ⓐppGroup) var separator: 📚TextConvert.Separator = .tab
    @Published var pastedText: String = ""
    @Published var showFileImporter: Bool = false
    @Published var alertError: Bool = false
    @Published var caughtError: 📥Error?
    @Published var navigationPath: NavigationPath = .init()
}

extension 📥NotesImportModel {
    func fileImporterAction(_ ⓡesult: Result<URL, Error>) {
        do {
            let ⓤrl = try ⓡesult.get()
            if ⓤrl.startAccessingSecurityScopedResource() {
                let ⓣext = try String(contentsOf: ⓤrl)
                if self.exceedingDataSize(ⓣext) {
                    self.caughtError = .dataSizeLimitExceeded
                    self.alertError = true
                } else {
                    self.navigationPath.append(ⓣext)
                }
                ⓤrl.stopAccessingSecurityScopedResource()
            }
        } catch {
            self.caughtError = .others(error.localizedDescription)
            self.alertError = true
        }
    }
    func importPastedText() {
        if self.exceedingDataSize(self.pastedText) {
            self.caughtError = .dataSizeLimitExceeded
            self.alertError = true
        } else {
            self.navigationPath.append(self.pastedText)
        }
    }
    func exceedingDataSize(_ ⓒonvertingText: String) -> Bool {
        let ⓒonvertingNotes = 📚TextConvert.decode(ⓒonvertingText, self.separator)
        let ⓔxistingNotes = 📚Notes.load() ?? []
        return (ⓒonvertingNotes.dataCount + ⓔxistingNotes.dataCount) > 800000
    }
    func cancel() {
        UINotificationFeedbackGenerator().notificationOccurred(.warning)
        self.navigationPath.removeLast()
    }
}

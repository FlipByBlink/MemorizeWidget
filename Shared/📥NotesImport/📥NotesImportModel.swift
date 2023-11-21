import SwiftUI

@MainActor
class 📥NotesImportModel: ObservableObject {
    @AppStorage(🎛️Key.Import.textSeparator, store: .ⓐppGroup) var separator: 📚TextConvert.Separator = .tab
    @Published var pastedText: String = ""
    @Published var showFileImporter: Bool = false
    @Published var alertError: Bool = false
    @Published var caughtError: 📥Error?
    @Published var navigationPath: NavigationPath = .init()
#if os(iOS)
    @AppStorage(🎛️Key.Import.inputMode, store: .ⓐppGroup) var inputMode: 📥InputMode = .file
#endif
}

extension 📥NotesImportModel {
    func fileImporterAction(_ ⓡesult: Result<URL, Error>) {
        do {
            let ⓤrl = try ⓡesult.get()
            if ⓤrl.startAccessingSecurityScopedResource() {
                let ⓣext = try String(contentsOf: ⓤrl)
                if self.exceedingDataSize(ⓣext) {
                    self.setAlert(.dataSizeLimitExceeded)
                } else {
                    self.presentConvertedNotesMenu(ⓣext)
                }
                ⓤrl.stopAccessingSecurityScopedResource()
            }
        } catch {
            self.setAlert(.others(error.localizedDescription))
        }
    }
    func importPastedText() {
        if self.exceedingDataSize(self.pastedText) {
            self.setAlert(.dataSizeLimitExceeded)
        } else {
            self.presentConvertedNotesMenu(self.pastedText)
        }
    }
    func cancel() {
        self.navigationPath.removeLast()
        💥Feedback.light()
    }
}

private extension 📥NotesImportModel {
    private func presentConvertedNotesMenu(_ ⓣext: String) {
        self.navigationPath.append(ⓣext)
        💥Feedback.success()
    }
    private func setAlert(_ ⓔrror: 📥Error) {
        self.caughtError = ⓔrror
        self.alertError = true
        💥Feedback.warning()
    }
    private func exceedingDataSize(_ ⓒonvertingText: String) -> Bool {
        let ⓒonvertingNotes = 📚TextConvert.decode(ⓒonvertingText, self.separator)
        let ⓔxistingNotes = 📚Notes.load() ?? []
        return (ⓒonvertingNotes.dataCount + ⓔxistingNotes.dataCount) > 800000
    }
}

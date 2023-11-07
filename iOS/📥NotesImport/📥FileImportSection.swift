import SwiftUI

struct 📥FileImportSection: View {
    @EnvironmentObject var model: 📱AppModel
    @Binding var importedText: String
    @State private var showFileImporter: Bool = false
    @State private var alertError: Bool = false
    @State private var caughtError: 📥Error?
    var body: some View {
        Section {
            📥SeparatorPicker()
            Button {
                self.showFileImporter.toggle()
            } label: {
                Label("Import a text-encoded file", systemImage: "folder.badge.plus")
                    .padding(.vertical, 8)
            }
            .fileImporter(isPresented: self.$showFileImporter,
                          allowedContentTypes: [.text],
                          onCompletion: self.action)
            .alert("⚠️", isPresented: self.$alertError) {
                Button("OK") { self.caughtError = nil }
            } message: {
                self.caughtError?.messageText()
            }
        }
    }
    init(_ importedText: Binding<String>) {
        self._importedText = importedText
    }
}

private extension 📥FileImportSection {
    private func action(_ ⓡesult: Result<URL, Error>) {
        do {
            let ⓤrl = try ⓡesult.get()
            if ⓤrl.startAccessingSecurityScopedResource() {
                let ⓣext = try String(contentsOf: ⓤrl)
                if self.model.exceedDataSize(ⓣext) {
                    self.caughtError = .dataSizeLimitExceeded
                    self.alertError = true
                } else {
                    self.importedText = ⓣext
                }
                ⓤrl.stopAccessingSecurityScopedResource()
            }
        } catch {
            self.caughtError = .others(error.localizedDescription)
            self.alertError = true
        }
    }
}

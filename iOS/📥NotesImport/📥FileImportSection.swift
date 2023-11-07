import SwiftUI

struct 📥FileImportSection: View {
    @EnvironmentObject var model: 📱AppModel
    @Binding var importedText: String
    @State private var showFileImporter: Bool = false
    @AppStorage("separator", store: .ⓐppGroup) var separator: 📚TextConvert.Separator = .tab
    @State private var 🚨alertDataSizeLimitExceeded: Bool = false
    @State private var 🚨showErrorAlert: Bool = false
    @State private var 🚨errorMessage: String = ""
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
            .alert("⚠️ Data size limitation", isPresented: self.$🚨alertDataSizeLimitExceeded) {
                Button("Yes") { self.🚨alertDataSizeLimitExceeded = false }
            } message: {
                Text("Total notes data over 800kB. Please decrease notes.")
            }
            .alert("⚠️", isPresented: self.$🚨showErrorAlert) {
                Button("OK") {
                    self.🚨showErrorAlert = false
                    self.🚨errorMessage = ""
                }
            } message: {
                Text(self.🚨errorMessage)
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
                let ⓓataCount = 📚TextConvert.decode(ⓣext, self.separator).dataCount
                guard (ⓓataCount + self.model.notes.dataCount) < 800000 else {
                    self.🚨alertDataSizeLimitExceeded = true
                    return
                }
                self.importedText = ⓣext
                ⓤrl.stopAccessingSecurityScopedResource()
            }
        } catch {
            self.🚨errorMessage = error.localizedDescription
            self.🚨showErrorAlert = true
        }
    }
    //enum 🚨Error: Error {
    //    case dataSizeLimitExceeded, others
    //}
}

import SwiftUI

struct 📥FileImportSection: View {
    @EnvironmentObject var model: 📱AppModel
    @Binding var importedText: String
    @State private var showFileImporter: Bool = false
    @AppStorage("separator", store: .ⓐppGroup) var separator: 📚TextConvert.Separator = .tab
    @State private var alertError: Bool = false
    @State private var 🚨error: Self.🚨Error?
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
                Button("OK") {
                    self.alertError = false
                    self.🚨error = nil
                }
            } message: {
                switch self.🚨error {
                    case .dataSizeLimitExceeded:
                        Text("Total notes data over 800kB. Please decrease notes.")
                    case .others(let ⓛocalizedDescription):
                        Text(ⓛocalizedDescription)
                    default:
                        EmptyView()
                }
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
                    self.🚨error = .dataSizeLimitExceeded
                    self.alertError = true
                    return
                }
                self.importedText = ⓣext
                ⓤrl.stopAccessingSecurityScopedResource()
            }
        } catch {
            self.🚨error = .others(error.localizedDescription)
            self.alertError = true
        }
    }
    private enum 🚨Error: Error {
        case dataSizeLimitExceeded, others(String)
    }
}

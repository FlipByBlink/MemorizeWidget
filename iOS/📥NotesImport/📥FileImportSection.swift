import SwiftUI

struct 📥FileImportSection: View {
    @EnvironmentObject var model: 📥NotesImportModel
    var body: some View {
        Section {
            📥SeparatorPicker()
            Button {
                self.model.showFileImporter.toggle()
            } label: {
                Label("Import a text-encoded file", systemImage: "folder.badge.plus")
                    .padding(.vertical, 8)
            }
            .fileImporter(isPresented: self.$model.showFileImporter,
                          allowedContentTypes: [.text]) {
                self.model.fileImporterAction($0)
            }
            .alert("⚠️", isPresented: self.$model.alertError) {
                Button("OK") { self.model.caughtError = nil }
            } message: {
                self.model.caughtError?.messageText()
            }
        }
    }
}

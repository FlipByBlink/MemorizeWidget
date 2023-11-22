import SwiftUI

struct 📥NotesImportFileSheetView: View {
    @StateObject private var model: 📥NotesImportModel = .init()
    var body: some View {
        NavigationStack(path: self.$model.navigationPath) {
            Form {
                📥SeparatorPicker()
                📥NotSupportMultiLineTextInNoteSection()
            }
            .formStyle(.grouped)
            .toolbar {
                📥DismissButton()
                ToolbarItem(placement: .primaryAction) {
                    if self.model.navigationPath.isEmpty {
                        Button {
                            self.model.showFileImporter.toggle()
                        } label: {
                            Label("Import a text-encoded file", systemImage: "folder.badge.plus")
                        }
                    }
                }
            }
            .environmentObject(self.model)
            .navigationDestination(for: String.self) {
                📥ConvertedNotesMenu(importedText: $0)
                    .environmentObject(self.model)
            }
            .navigationTitle("Import notes")
            .fileImporter(isPresented: self.$model.showFileImporter, allowedContentTypes: [.text]) {
                self.model.fileImporterAction($0)
            }
            .alert("⚠️ Error", isPresented: self.$model.alertError) {
                Button("OK") { self.model.caughtError = nil }
            } message: {
                self.model.caughtError?.messageText()
            }
        }
        .frame(width: 400, height: 360)
    }
}

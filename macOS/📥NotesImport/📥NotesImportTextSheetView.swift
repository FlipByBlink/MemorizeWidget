import SwiftUI

struct 📥NotesImportTextSheetView: View {
    @StateObject private var model: 📥NotesImportModel = .init()
    var body: some View {
        NavigationStack(path: self.$model.navigationPath) {
            List {
                Text("📥FileImportSection()")
                📥NotSupportMultiLineTextInNoteSection()
            }
            .environmentObject(self.model)
            .navigationDestination(for: String.self) { _ in
                Text("📥ConvertedNotesMenu(importedText: $0)")
                    .environmentObject(self.model)
            }
            .navigationTitle("Import notes")
        }
        .toolbar { Button("Dismiss") {} }
        .frame(width: 400, height: 500)
    }
}

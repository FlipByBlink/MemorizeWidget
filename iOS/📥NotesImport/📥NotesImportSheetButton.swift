import SwiftUI

struct 📥NotesImportSheetButton: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        Button {
            self.model.presentSheetOnContentView(.notesImport)
        } label: {
            Label("Import notes", systemImage: "tray.and.arrow.down")
        }
        .modifier(📚DisableInEditMode())
    }
}

import SwiftUI

struct 📥NotesImportSheetButton: View {
    @EnvironmentObject var model: 📱AppModel
    @Environment(\.editMode) var editMode
    var body: some View {
        Button {
            self.model.presentSheet(.notesImport)
        } label: {
            Label("Import notes", systemImage: "tray.and.arrow.down")
        }
        .disabled(self.editMode?.wrappedValue == .active)
    }
}

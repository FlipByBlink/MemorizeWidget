import SwiftUI

struct 📚NotesMenuButton: ToolbarContent { // 🪄
    @EnvironmentObject var model: 📱AppModel
    let placement: ToolbarItemPlacement
    var body: some ToolbarContent {
        ToolbarItem(placement: self.placement) {
            Menu {
                if UIDevice.current.userInterfaceIdiom == .phone {
                    📥NotesImportSheetButton()
                }
                self.notesExportSheetButton()
                Divider()
                🚮DeleteAllNotesButton()
            } label: {
                Label("Menu", systemImage: "wand.and.rays")
            }
            .modifier(🚮DeleteAllNotesButton.ConfirmDialog())
            .modifier(📚DisableInEditMode())
        }
    }
}

private extension 📚NotesMenuButton {
    private func notesExportSheetButton() -> some View {
        Button {
            self.model.presentSheetOnContentView(.notesExport)
        } label: {
            Label("Export notes", systemImage: "tray.and.arrow.up")
        }
        .disabled(self.model.notes.isEmpty)
    }
}

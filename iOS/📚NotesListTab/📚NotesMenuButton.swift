import SwiftUI

struct 📚NotesMenuButton: ToolbarContent { // 🪄
    @EnvironmentObject var model: 📱AppModel
    @Environment(\.editMode) var editMode
    let placement: ToolbarItemPlacement
    var body: some ToolbarContent {
        ToolbarItem(placement: self.placement) {
            Menu {
                if UIDevice.current.userInterfaceIdiom == .phone {
                    📥NotesImportSheetButton()
                }
                self.notesExportSheetButton()
                Divider()
                self.customizeSearchSheetButton()
                Divider()
                🚮DeleteAllNotesButton()
            } label: {
                Label("Menu", systemImage: "wand.and.rays")
            }
            .disabled(self.editMode?.wrappedValue == .active)
        }
    }
}

private extension 📚NotesMenuButton {
    private func customizeSearchSheetButton() -> some View {
        Button {
            self.model.presentSheet(.customizeSearch)
        } label: {
            Label("Customize search", systemImage: "magnifyingglass")
        }
    }
    private func notesExportSheetButton() -> some View {
        Button {
            self.model.presentSheet(.notesExport)
        } label: {
            Label("Export notes", systemImage: "tray.and.arrow.up")
        }
        .disabled(self.model.notes.isEmpty)
    }
}

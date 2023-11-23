import SwiftUI

struct 📰SheetHandlerOnContentView: ViewModifier {
    @EnvironmentObject var model: 📱AppModel
    func body(content: Content) -> some View {
        content
            .sheet(item: self.$model.presentedSheetOnContentView) {
                switch $0 {
                    case .widget: 📖WidgetSheetView()
                    case .notesImportFile: 📥NotesImportFileSheetView()
                    case .notesImportText: 📥NotesImportTextSheetView()
                    case .notesExport: 📤NotesExportSheetView()
                }
            }
            .onChange(of: self.model.presentedSheetOnContentView) {
                if $0 != nil { self.clearSelectionOnPresentingSheet() }
            }
    }
}

private extension 📰SheetHandlerOnContentView {
    func clearSelectionOnPresentingSheet() {
        self.model.clearSelection()
    }
}

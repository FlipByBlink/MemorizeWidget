import SwiftUI

struct 📰SheetHandlerOnContentView: ViewModifier {
    @EnvironmentObject var model: 📱AppModel
    func body(content: Content) -> some View {
        content
            .sheet(item: self.$model.presentedSheetOnContentView) {
                switch $0 {
                    case .widget: Text("📖WidgetSheetView()")
                    case .notesImport: Text("📥NotesImportSheetView()")
                    case .notesExport: Text("📤NotesExportSheetView()")
                }
            }
    }
}

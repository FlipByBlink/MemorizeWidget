import SwiftUI

struct 📰SheetHandlerOnContentView: ViewModifier {
    @EnvironmentObject var model: 📱AppModel
    func body(content: Content) -> some View {
        content
            .sheet(item: self.$model.presentedSheetOnContentView) {
                switch $0 {
                    case .widget: 📖WidgetSheetView()
                    case .notesImport: 📥NotesImportSheetView()
                    case .notesExport: 📤NotesExportSheetView()
                    case .customizeSearch: 🔍CustomizeSearchSheetView()
                    case .search(let ⓥiewController): 🔍SearchSheetView(ⓥiewController)
                    case .dictionary(let ⓥiewController): 📘DictionarySheetView(ⓥiewController)
                    case .aboutApp: Self.aboutAppSheetView()
                    case .purchase: Self.purchaseSheetView()
                }
            }
            .modifier(📖DismissWidgetSheetOnBackground())
    }
}

private extension 📰SheetHandlerOnContentView {
    private static func aboutAppSheetView() -> some View {
        NavigationStack {
            List {
                ℹ️AboutAppContent()
            }
            .navigationTitle(.init("About App", tableName: "🌐AboutApp"))
            .toolbar { 📰DismissButton() }
        }
    }
    private static func purchaseSheetView() -> some View {
        NavigationStack {
            🛒InAppPurchaseMenu()
                .toolbar { 📰DismissButton() }
        }
    }
}

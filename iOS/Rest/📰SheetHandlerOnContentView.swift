import SwiftUI

struct 📰SheetHandlerOnContentView: ViewModifier {
    @EnvironmentObject var model: 📱AppModel
    func body(content: Content) -> some View {
        content
            .sheet(item: self.$model.presentedSheetOnContentView) { ⓘtem in
                if case .dictionary(let ⓥiewController) = ⓘtem {
                    📘DictionarySheetView(ⓥiewController)
                } else {
                    NavigationStack {
                        Group {
                            switch ⓘtem {
                                case .widget: 📖WidgetSheetView()
                                case .notesImport: 📥NotesImportSheetView()
                                case .notesExport: 📤ExportNotesSheetView()
                                case .customizeSearch: 🔍CustomizeSearchSheetView()
                                case .dictionary(_): EmptyView()
                                case .aboutApp: Self.aboutAppSheetView()
                                case .purchase: 🛒InAppPurchaseMenu()
                            }
                        }
                        .toolbar { Self.DismissButton() }
                    }
                }
            }
            .modifier(📖DismissWidgetSheetOnBackground())
    }
}

private extension 📰SheetHandlerOnContentView {
    private static func aboutAppSheetView() -> some View {
        List {
            ℹ️AboutAppContent()
        }
        .navigationTitle(.init("About App", tableName: "🌐AboutApp"))
    }
    private struct DismissButton: ToolbarContent {
        @EnvironmentObject var model: 📱AppModel
        var body: some ToolbarContent {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    self.model.presentedSheetOnContentView = nil
                    UISelectionFeedbackGenerator().selectionChanged()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .symbolRenderingMode(.hierarchical)
                        .font(.title3)
                        .foregroundStyle(Color.secondary)
                }
                .keyboardShortcut(.cancelAction)
            }
        }
    }
}

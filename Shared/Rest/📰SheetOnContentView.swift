import SwiftUI

enum 📰SheetOnContentView {
    case widget(🪧Tag)
#if os(iOS)
    case notesImport
    case dictionary(UIReferenceLibraryViewController)
#elseif os(watchOS)
    case newNoteShortcut
#endif
}

extension 📰SheetOnContentView: Identifiable, Hashable {
    var id: Self { self }
    struct Handler: ViewModifier {
        @EnvironmentObject var model: 📱AppModel
        func body(content: Content) -> some View {
            content
                .sheet(item: self.$model.presentedSheetOnContentView) {
                    switch $0 {
                        case .widget: 📖WidgetSheetView()
#if os(iOS)
                        case .notesImport: 📥NotesImportView()
                        case .dictionary(let ⓥiewController): 📘DictionaryView(ⓥiewController)
#elseif os(watchOS)
                        case .newNoteShortcut: 🆕NewNoteShortcutView()
#endif
                    }
                }
#if os(iOS)
                .modifier(📖DismissWidgetSheetOnBackground())
#endif
        }
    }
    var widgetTag: 🪧Tag? {
        if case .widget(let ⓣag) = self { ⓣag } else { nil }
    }
}

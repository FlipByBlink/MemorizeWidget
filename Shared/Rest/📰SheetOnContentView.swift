import SwiftUI

enum 📰SheetOnContentView {
    case widget(🪧Tag)
#if os(iOS)
    case notesImport
#endif
#if os(macOS)
    case notesImportFile
    case notesImportText
#endif
#if os(iOS) || os(macOS)
    case notesExport
#endif
#if os(iOS)
    case customizeFontSize
    case customizeSearch
    case search(URL)
    case dictionary(UIReferenceLibraryViewController)
    case aboutApp
    case purchase
#endif
#if os(watchOS)
    case newNoteShortcut
#endif
}

extension 📰SheetOnContentView: Identifiable, Hashable {
    var id: Self { self }
}

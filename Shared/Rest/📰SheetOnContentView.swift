import SwiftUI

enum 📰SheetOnContentView {
    case widget(🪧Tag)
#if os(iOS)
    case notesImport
    case notesExport
    case customizeFontSize
    case customizeSearch
    case search(URL)
    case dictionary(UIReferenceLibraryViewController)
    case aboutApp
    case purchase
#elseif os(watchOS)
    case newNoteShortcut
#endif
}

extension 📰SheetOnContentView: Identifiable, Hashable {
    var id: Self { self }
}

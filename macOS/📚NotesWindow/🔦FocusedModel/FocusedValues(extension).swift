import SwiftUI

extension FocusedValues {
    var editingNote: Self.EditingNoteKey.Value? {
        get { self[Self.EditingNoteKey.self] }
        set { self[Self.EditingNoteKey.self] = newValue }
    }
    struct EditingNoteKey: FocusedValueKey { typealias Value = 📗Note }
    
    var notes: Self.NotesKey.Value? {
        get { self[Self.NotesKey.self] }
        set { self[Self.NotesKey.self] = newValue }
    }
    struct NotesKey: FocusedValueKey { typealias Value = 📚Notes }
    
    var notesSelection: Self.NotesSelectionKey.Value? {
        get { self[Self.NotesSelectionKey.self] }
        set { self[Self.NotesSelectionKey.self] = newValue }
    }
    struct NotesSelectionKey: FocusedValueKey { typealias Value = Set<UUID> }
    
    var openedMainWindow: Self.OpenedMainWindow.Value? {
        get { self[Self.OpenedMainWindow.self] }
        set { self[Self.OpenedMainWindow.self] = newValue }
    }
    struct OpenedMainWindow: FocusedValueKey { typealias Value = Bool }
    
    var presentedSheetOnContentView: Self.PresentedSheetOnContentView.Value? {
        get { self[Self.PresentedSheetOnContentView.self] }
        set { self[Self.PresentedSheetOnContentView.self] = newValue }
    }
    struct PresentedSheetOnContentView: FocusedValueKey { typealias Value = 📰SheetOnContentView }
}

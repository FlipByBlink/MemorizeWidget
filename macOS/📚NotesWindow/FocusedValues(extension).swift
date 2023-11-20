import SwiftUI

extension FocusedValues {
    var フォーカス値: Self.フォーカスキー.Value? {
        get { self[Self.フォーカスキー.self] }
        set { self[Self.フォーカスキー.self] = newValue }
    }
    struct フォーカスキー: FocusedValueKey { typealias Value = UUID }
    
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
    
    //struct フォーカスキー: FocusedValueKey { typealias Value = Binding<UUID> }
    
    //@FocusedValue(\.フォーカス値) private var 現在のフォーカス
    //"focusable"の外側に"focusedValue(\.フォーカス値, _)"を呼ぶ。
}

//#if DEBUG
struct FocusedValuesモニター: ViewModifier {
    @FocusedValue(\.notes) var notes
    @FocusedValue(\.notesSelection) var notesSelection
    //@FocusedBinding(\.フォーカス値) var 現在のフォーカス
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .accessoryBar(id: "1")) {
                    Text("notes: " + self.notes.debugDescription)
                }
                ToolbarItem(placement: .accessoryBar(id: "2")) {
                    Text("notesSelection: " + self.notesSelection.debugDescription)
                }
            }
    }
}
//#endif

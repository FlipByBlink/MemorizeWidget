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

//struct FocusedValuesモニター: View {
//    @FocusedValue(\.フォーカス値) var 現在のフォーカス
//    //@FocusedBinding(\.フォーカス値) var 現在のフォーカス
//    var body: some View {
//        Text("フォーカス値: " + self.現在のフォーカス.debugDescription)
//    }
//}

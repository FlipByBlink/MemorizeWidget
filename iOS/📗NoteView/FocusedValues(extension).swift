import SwiftUI

extension FocusedValues {
    var editingNote: Self.EditingNoteKey.Value? {
        get { self[Self.EditingNoteKey.self] }
        set { self[Self.EditingNoteKey.self] = newValue }
    }
    struct EditingNoteKey: FocusedValueKey { typealias Value = 📗Note }
}

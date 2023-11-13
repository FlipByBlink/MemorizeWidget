import SwiftUI

struct 📚DisableInEditMode: ViewModifier {
    @Environment(\.editMode) var editMode
    func body(content: Content) -> some View {
        content
            .disabled(self.editMode?.wrappedValue == .active)
    }
}

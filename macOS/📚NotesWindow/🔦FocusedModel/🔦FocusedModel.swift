import SwiftUI

struct 🔦FocusedModel: ViewModifier {
    @EnvironmentObject var model: 📱AppModel
    func body(content: Content) -> some View {
        content
            .focusedValue(\.notesSelection, self.model.notesSelection)
            .focusedValue(\.notes, self.model.notes)
            .focusedValue(\.openedMainWindow, true)
            .focusedObject(self.model)
    }
}

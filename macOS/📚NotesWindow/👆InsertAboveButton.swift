import SwiftUI

struct 👆InsertAboveButton: View {
    @FocusedObject var model: 📱AppModel?
    @FocusedValue(\.editingNote) var editingNote
    private var notes: Set<📗Note>
    var body: some View {
        Button {
            self.model?.insertAbove(self.notes)
        } label: {
            Label("Insert above", systemImage: "text.insert")
        }
        .disabled(
            (self.notes.count != 1)
            ||
            (self.editingNote?.title.isEmpty == true)
        )
    }
    init(_ notes: Set<📗Note>) {
        self.notes = notes
    }
}

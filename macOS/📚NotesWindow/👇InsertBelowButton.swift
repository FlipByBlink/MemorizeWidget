import SwiftUI

struct 👇InsertBelowButton: View {
    @FocusedObject var model: 📱AppModel?
    @FocusedValue(\.editingNote) var editingNote
    private var notes: Set<📗Note>
    var body: some View {
        Button {
            self.model?.insertBelow(self.notes)
        } label: {
            Label("Insert below", systemImage: "text.append")
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

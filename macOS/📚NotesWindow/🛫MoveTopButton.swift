import SwiftUI

struct 🛫MoveTopButton: View {
    @FocusedObject var model: 📱AppModel?
    private var notes: Set<📗Note>
    var body: some View {
        Button {
            self.model?.moveTop(self.notes)
        } label: {
            Label("Move top", systemImage: "arrow.up.to.line")
        }
        .disabled(
            self.notes.isEmpty
            ||
            self.notes.contains { $0 == self.model?.notes.first }
        )
    }
    init(_ notes: Set<📗Note>) {
        self.notes = notes
    }
}

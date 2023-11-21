import SwiftUI

struct 🛬MoveEndButton: View {
    @FocusedObject var model: 📱AppModel?
    private var notes: Set<📗Note>
    var body: some View {
        Button {
            self.model?.moveEnd(self.notes)
        } label: {
            Label("Move end", systemImage: "arrow.down.to.line")
        }
        .disabled(
            self.notes.isEmpty
            ||
            self.notes.contains { $0 == self.model?.notes.last }
        )
    }
    init(_ notes: Set<📗Note>) {
        self.notes = notes
    }
}

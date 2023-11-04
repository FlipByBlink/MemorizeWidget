import SwiftUI

struct 📖MoveEndButton: View {
    @EnvironmentObject var model: 📱AppModel
    private var note: 📗Note
    @State private var done: Bool = false
    var body: some View {
        Button {
            self.model.moveEnd(self.note)
            withAnimation { self.done = true }
        } label: {
            Label("Move end", systemImage: "arrow.down.to.line")
        }
        .disabled(self.model.notes.last == self.note)
        .opacity(self.done ? 0.33 : 1)
        .overlay {
            if self.done {
                Image(systemName: "checkmark")
                    .imageScale(.small)
                    .symbolRenderingMode(.hierarchical)
            }
        }
    }
    init(_ note: 📗Note) {
        self.note = note
    }
}

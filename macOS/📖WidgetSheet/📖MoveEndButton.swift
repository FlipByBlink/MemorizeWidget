import SwiftUI

struct 📖MoveEndButton: View {
    @EnvironmentObject var model: 📱AppModel
    private var note: 📗Note
    @State private var done: Bool = false
    var body: some View {
        if !self.model.randomMode {
            Button {
                self.model.moveEnd([self.note])
                withAnimation(.default.speed(2)) { self.done = true }
            } label: {
                Label("Move end", systemImage: "arrow.down.to.line")
            }
            .disabled(self.model.notes.last == self.note)
            .opacity(self.done ? 0 : 1)
            .overlay {
                if self.done {
                    Image(systemName: "checkmark")
                        .fontWeight(.semibold)
                }
            }
        }
    }
    init(_ note: 📗Note) {
        self.note = note
    }
}

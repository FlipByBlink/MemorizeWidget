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
            .overlay {
                if self.done {
                    Image(systemName: "checkmark")
                        .fontWeight(.heavy)
                        .background(.background)
                }
            }
        }
    }
    init(_ note: 📗Note) {
        self.note = note
    }
}

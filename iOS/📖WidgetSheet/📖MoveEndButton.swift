import SwiftUI

struct 📖MoveEndButton: View {
    @EnvironmentObject var model: 📱AppModel
    private var note: 📗Note
    @State private var done: Bool = false
    var body: some View {
        Button {
            self.model.moveEnd(self.note)
            withAnimation(.default.speed(1.5)) { self.done = true }
        } label: {
            Label("Move end", systemImage: "arrow.down.to.line")
                .padding(8)
        }
        .hoverEffect()
        .disabled(self.model.notes.last == self.note)
        .opacity(self.done ? 0 : 1)
        .overlay {
            if self.done {
                Image(systemName: "checkmark.circle.fill")
                    .imageScale(.large)
                    .fontWeight(.heavy)
                    .foregroundStyle(.tertiary)
            }
        }
    }
    init(_ note: 📗Note) {
        self.note = note
    }
}

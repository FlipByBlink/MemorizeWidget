import SwiftUI

struct 🗑DeleteNoteButton: View {
    @EnvironmentObject var 📱: 📱AppModel
    private var ⓝote: 📗Note
    var body: some View {
        Button(role: .destructive) {
            withAnimation {
                📱.📚notes.removeAll { $0 == self.ⓝote }
            }
            UINotificationFeedbackGenerator().notificationOccurred(.warning)
        } label: {
            Label("Delete", systemImage: "trash")
        }
    }
    init(_ note: 📗Note) {
        self.ⓝote = note
    }
}

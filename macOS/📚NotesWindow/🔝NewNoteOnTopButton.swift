import SwiftUI

struct 🔝NewNoteOnTopButton: View {
    @FocusedObject var model: 📱AppModel?
    var body: some View {
        Button {
            self.model?.addNewNoteOnTop()
        } label: {
            Label("New note on top", systemImage: "plus")
        }
    }
}

import SwiftUI

struct 🆕NewNoteShortcutView: View {
    @EnvironmentObject var model: 📱AppModel
    @State private var note: 📗Note = .empty
    var body: some View {
        List {
            TextField("Title", text: self.$note.title)
                .font(.headline)
            TextField("Comment", text: self.$note.comment)
                .font(.subheadline)
                .opacity(self.note.title.isEmpty ? 0.33 : 1)
            self.submitButton()
        }
        .animation(.default, value: self.note.title.isEmpty)
        .onDisappear { self.note = .empty }
    }
}

private extension 🆕NewNoteShortcutView {
    private func submitButton() -> some View {
        Section {
            Button {
                self.model.addNewNoteOnShortcutSheet(self.note)
            } label: {
                Label("Done", systemImage: "checkmark")
            }
            .buttonStyle(.bordered)
            .listRowBackground(Color.clear)
            .fontWeight(.semibold)
            .disabled(self.note.title.isEmpty)
            .foregroundStyle(self.note.title.isEmpty ? .tertiary : .primary)
        }
    }
}

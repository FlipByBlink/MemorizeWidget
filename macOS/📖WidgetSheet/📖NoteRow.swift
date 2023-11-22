import SwiftUI

struct 📖NoteRow: View {
    @EnvironmentObject var model: 📱AppModel
    @Binding var source: 📗Note
    var body: some View {
        HStack(spacing: 16) {
            VStack(spacing: 7) {
                TextField("No title", text: self.$source.title, axis: .vertical)
                    .font(.title.weight(.semibold))
                    .textFieldStyle(.plain)
                TextField("No comment", text: self.$source.comment, axis: .vertical)
                    .disabled(self.source.title.isEmpty)
                    .font(.title3.weight(.light))
                    .textFieldStyle(.plain)
            }
            .focusedValue(\.editingNote, self.source)
            .onSubmit { self.model.submitTextField(self.source) }
            HStack(spacing: 12) {
                🔍SearchButton([self.source])
                📘DictionaryButton([self.source])
                📖MoveEndButton(self.source)
                self.removeButton()
            }
            .labelStyle(.iconOnly)
        }
        .padding(.vertical, 12)
        .padding(.leading, 8)
        .padding(.trailing, 4)
        .frame(minHeight: 150)
    }
}

private extension 📖NoteRow {
    private func removeButton() -> some View {
        Button {
            self.model.removeNote(self.source)
        } label: {
            Label("Delete", systemImage: "trash")
        }
    }
}

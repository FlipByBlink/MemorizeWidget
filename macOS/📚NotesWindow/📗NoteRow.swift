import SwiftUI

struct 📗NoteRow: View {
    @EnvironmentObject var model: 📱AppModel
    @Binding var source: 📗Note
    var body: some View {
        HStack(spacing: 4) {
            VStack(spacing: 2) {
                TextField("No title", text: self.$source.title, axis: .vertical)
                    .font(.title3.bold())
                TextField("No comment", text: self.$source.comment, axis: .vertical)
                    .disabled(self.source.title.isEmpty)
                    .font(.body.weight(.light))
            }
            .focusedValue(\.editingNote, self.source)
            .onSubmit { self.model.submitTextField(self.source) }
            Self.RemoveButton(self.source)
        }
        .padding(.vertical, 6)
        .padding(.leading, 6)
        .padding(.trailing, 2)
    }
}

private extension 📗NoteRow {
    private struct RemoveButton: View {
        @EnvironmentObject var model: 📱AppModel
        @State private var hovering: Bool = false
        private var source: 📗Note
        var body: some View {
            Button {
                self.model.removeNote(self.source)
            } label: {
                Image(systemName: "trash")
                    .font(.title3.weight(.medium))
                    .padding(4)
                    .contentShape(Rectangle())
            }
            .buttonStyle(.borderless)
            .foregroundStyle(self.hovering ? .primary : .tertiary)
            .animation(.default.speed(2), value: self.hovering)
            .onHover { self.hovering = $0 }
        }
        init(_ source: 📗Note) {
            self.source = source
        }
    }
}

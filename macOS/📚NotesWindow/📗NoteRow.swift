import SwiftUI

struct 📗NoteRow: View {
    @EnvironmentObject var model: 📱AppModel
    @Binding var source: 📗Note
    var body: some View {
        HStack(spacing: 12) {
            VStack(spacing: 4) {
                TextField("No title", text: self.$source.title, axis: .vertical)
                    .font(.system(size: 17))
                    .fontWeight(self.thinTitle ? .light : .semibold)
                TextField("No comment", text: self.$source.comment, axis: .vertical)
                    .disabled(self.source.title.isEmpty)
                    .font(.body.weight(.light))
            }
            .fixedSize(horizontal: false, vertical: true)
            .focusedValue(\.editingNote, self.source)
            .onSubmit { self.model.notesSelection = [self.source.id] }
            Self.RemoveButton(self.source)
        }
        .padding(.vertical, 10)
        .padding(.leading, 10)
        .padding(.trailing, 4)
    }
}

private extension 📗NoteRow {
    private var thinTitle: Bool {
        !self.model.randomMode
        && 
        self.source != self.model.notes.first
    }
    private struct RemoveButton: View {
        @EnvironmentObject var model: 📱AppModel
        @FocusedValue(\.editingNote) var editingNote
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
            .disabled(self.editingNote != nil)
        }
        init(_ source: 📗Note) {
            self.source = source
        }
    }
}

//Workaround(macOS 14.1.1): There is a bug that the last line of multiple lines is hidden. This problem was resolved by fixedSize(horizontal: false, vertical: true).

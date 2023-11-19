import SwiftUI

struct 📗NoteView: View {
    @EnvironmentObject var model: 📱AppModel
    @FocusState private var titleFocus: Bool
    @Binding var source: 📗Note
    var body: some View {
        HStack(spacing: 4) {
            VStack(spacing: 2) {
                TextField("No title", text: self.$source.title, axis: .vertical)
                    .focused(self.$titleFocus)
                    .font(.title3.bold())
                TextField("No comment", text: self.$source.comment, axis: .vertical)
                    .disabled(self.source.title.isEmpty)
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(.secondary)
            }
            .focusedValue(\.フォーカス値, self.source.id)
            .onSubmit {
                self.model.saveNotes()
                self.model.notesSelection = [self.source.id]
            }
            Self.RemoveButton(self.source)
        }
        .padding(.vertical, 6)
        .padding(.leading, 4)
        .contextMenu {
            Button("辞書") {}
            Button("検索") {}
            Divider()
            Button("末尾へ移動") {}
            Button("先頭へ移動") {}
            Divider()
            Button("上に新規ノート") {}
            Button("下に新規ノート") {}
        }
        .onChange(of: self.model.createdNewNoteID) {
            if $0 == self.source.id {
                self.titleFocus = true
                self.model.createdNewNoteID = nil
            }
        }
    }
}

private extension 📗NoteView {
    private struct RemoveButton: View {
        @EnvironmentObject var model: 📱AppModel
        @State private var ホバー中: Bool = false
        var source: 📗Note
        var body: some View {
            Button {
                self.model.removeNote(self.source, feedback: false)
            } label: {
                Image(systemName: "trash")
                    .font(.title3.weight(.medium))
                    .padding(4)
                    .contentShape(Rectangle())
            }
            .buttonStyle(.borderless)
            .foregroundStyle(self.ホバー中 ? .primary : .tertiary)
            .animation(.default.speed(2), value: self.ホバー中)
            .onHover { self.ホバー中 = $0 }
        }
        init(_ source: 📗Note) {
            self.source = source
        }
    }
}

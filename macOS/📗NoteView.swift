import SwiftUI

struct 📗NoteView: View {
    @EnvironmentObject var model: 📱AppModel
    @FocusState private var titleFocus: Bool
    @Binding var source: 📗Note
    var body: some View {
        HStack(spacing: 4) {
            VStack(spacing: 4) {
                TextField("No title", text: self.$source.title, axis: .vertical)
                    .font(.headline)
                    .focused(self.$titleFocus)
                TextField("No comment", text: self.$source.comment, axis: .vertical)
                    .disabled(self.source.title.isEmpty)
                    .font(.subheadline.weight(.medium))
                    .opacity(self.model.notesSelection.contains(self.source.id)
                             && self.source.comment.isEmpty ? 0.5 : 1)
            }
            Self.ToolButton(kind: .dictionary)
            Self.ToolButton(kind: .search)
            Self.ToolButton(kind: .trash)
        }
        .padding(4)
        .onSubmit {
            self.model.saveNotes()
            self.model.notesSelection = [self.source.id]
        }
        .contextMenu {
            Button("先頭へ移動") {}
            Button("末尾へ移動") {}
            Divider()
            Button("上部へ新規ノート") {}
            Button("下部へ新規ノート") {}
        }
        .onChange(of: self.model.createdNewNoteID) {
            if $0 == self.source.id {
                self.titleFocus = true
                self.model.createdNewNoteID = nil
            }
        }
        .focusedValue(\.フォーカス値, self.source.id)
    }
}

private extension 📗NoteView {
    struct ToolButton: View {
        var kind: Self.Kind
        @State private var ホバー中: Bool = false
        var body: some View {
            Button {
                switch self.kind {
                    case .dictionary: break
                    case .search: break
                    case .trash: break
                }
            } label: {
                Image(systemName: self.kind.icon)
                    .padding(8)
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .font(.title3.weight(.medium))
            .foregroundStyle(self.ホバー中 ? .primary : .tertiary)
            .animation(.default.speed(2), value: self.ホバー中)
            .onHover { self.ホバー中 = $0 }
        }
        enum Kind {
            case dictionary, search, trash
            var icon: String {
                switch self {
                    case .dictionary: "character.book.closed"
                    case .search: "magnifyingglass"
                    case .trash: "trash"
                }
            }
        }
    }
}

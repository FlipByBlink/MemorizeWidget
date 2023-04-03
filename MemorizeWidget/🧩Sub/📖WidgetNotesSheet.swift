import SwiftUI

struct 📖WidgetNotesSheet: View { //MARK: Work in progress
    @EnvironmentObject var 📱: 📱AppModel
    private var ⓝoteIndex: Int? { 📱.widgetNoteIndex }
    private var ⓝote: 📗Note? {
        guard let ⓝoteIndex else { return nil }
        return 📱.📚notes[ⓝoteIndex]
    }
    var body: some View {
        NavigationView {
            Group {
                if .random() {
                    self.ⓢigleNoteLayout()
                } else {
                    self.ⓜultiNotesLayout()
                }
            }
            .toolbar { 🅧DismissButton() }
        }
        .navigationViewStyle(.stack)
    }
    private func ⓢigleNoteLayout() -> some View {
        Group {
            if let ⓝoteIndex, let ⓝote {
                VStack {
                    Spacer()
                    📓NoteView($📱.📚notes[ⓝoteIndex],
                               titleFont: .largeTitle,
                               commentFont: .title)
                    .padding(.horizontal, 32)
                    Spacer()
                    HStack {
                        Spacer()
                        📘DictionaryButton($📱.📚notes[ⓝoteIndex])
                        Spacer()
                        🔍SearchButton(ⓝote)
                        Spacer()
                        🗑DeleteNoteButton(ⓝote)
                        Spacer()
                    }
                    .labelStyle(.iconOnly)
                    .buttonStyle(.plain)
                    .foregroundColor(.primary)
                    .font(.title)
                    .padding(.horizontal, 24)
                    Spacer()
                }
            } else {
                🗑️DeletedNoteView()
            }
        }
    }
    private func ⓜultiNotesLayout() -> some View {
        List {
            self.ⓝoteRow()
        }
    }
    private func ⓝoteRow() -> some View {
        Section {
            if let ⓝoteIndex, let ⓝote {
                VStack(spacing: 0) {
                    📓NoteView($📱.📚notes[ⓝoteIndex],
                               titleFont: .title,
                               commentFont: .title3)
                    HStack {
                        Spacer()
                        📘DictionaryButton($📱.📚notes[ⓝoteIndex])
                        Spacer()
                        🔍SearchButton(ⓝote)
                        Spacer()
                        🗑DeleteNoteButton(ⓝote)
                        Spacer()
                    }
                    .labelStyle(.iconOnly)
                    .buttonStyle(.plain)
                    .foregroundColor(.primary)
                    .font(.title3)
                    .padding()
                }
                .padding(8)
            } else {
                🗑️DeletedNoteView()
            }
        }
    }
}

private struct 📘DictionaryButton: View {
    @Binding private var ⓣerm: String
    @State private var ⓢtate: 📘DictionaryState = .default
    var body: some View {
        Button {
            self.ⓢtate.request(self.ⓣerm)
        } label: {
            Label("Dictionary", systemImage: "character.book.closed")
        }
        .modifier(📘DictionarySheet(self.$ⓢtate))
    }
    init(_ note: Binding<📗Note>) {
        self._ⓣerm = note.title
    }
}

private struct 🗑️DeletedNoteView: View {
    var body: some View {
        HStack {
            Spacer()
            VStack(spacing: 24) {
                Label("Deleted.", systemImage: "checkmark")
                Image(systemName: "trash")
            }
            .foregroundColor(.primary)
            .imageScale(.small)
            .font(.largeTitle)
            Spacer()
        }
        .padding(24)
    }
}

private struct 🅧DismissButton: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        Button {
            📱.🚩showWidgetNoteSheet = false
        } label: {
            Image(systemName: "xmark.circle.fill")
                .symbolRenderingMode(.hierarchical)
        }
        .foregroundColor(.secondary)
    }
}

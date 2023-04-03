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
            List {
                self.ⓝoteRow()
            }
            .toolbar { 🅧DismissButton() }
        }
        .navigationViewStyle(.stack)
    }
    private func ⓝoteRow() -> some View {
        Section {
            if let ⓝoteIndex, let ⓝote {
                VStack(spacing: 0) {
                    📓NoteView($📱.📚notes[ⓝoteIndex])
                    HStack {
                        Spacer()
                        📘DictionaryButton($📱.📚notes[ⓝoteIndex])
                            .padding()
                        Spacer()
                        🔍SearchButton(ⓝote)
                            .padding()
                        Spacer()
                        🗑DeleteNoteButton(ⓝote)
                            .padding()
                        Spacer()
                    }
                    .labelStyle(.iconOnly)
                    .buttonStyle(.plain)
                    .foregroundColor(.primary)
                }
            } else {
                🗑️DeletedNoteView()
            }
        }
    }
}

private struct 📘DictionaryButton: View {
    @Binding private var ⓝote: 📗Note
    @State private var ⓢtate: 📘DictionaryState = .default
    var body: some View {
        Button {
            self.ⓢtate.request(self.ⓝote.title)
        } label: {
            Label("Dictionary", systemImage: "character.book.closed")
        }
        .modifier(📘DictionarySheet(self.$ⓢtate))
    }
    init(_ note: Binding<📗Note>) {
        self._ⓝote = note
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

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
                        📘DictionaryButton(ⓝote)
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
    private var ⓝote: 📗Note
    @State private var 🚩showSheet: Bool = false
    var body: some View {
        Button {
            self.🚩showSheet = true
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        } label: {
            Label("Dictionary", systemImage: "character.book.closed")
        }
        .modifier(📘DictionarySheet(ⓝote, self.$🚩showSheet))
    }
    init(_ note: 📗Note) {
        self.ⓝote = note
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

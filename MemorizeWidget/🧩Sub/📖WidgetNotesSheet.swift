import SwiftUI

struct 📖WidgetNotesSheet: View { //MARK: Work in progress
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        NavigationView {
            Group {
                if 📱.🆔widgetNotesID.count == 1 {
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
            if let ⓝote = 📱.📚notes.first(where: { $0.id == 📱.🆔widgetNotesID.first }),
               let ⓘndex = 📱.📚notes.firstIndex(where: { $0 == ⓝote }) {
                VStack {
                    Spacer()
                    📓NoteView($📱.📚notes[ⓘndex],
                               titleFont: .largeTitle,
                               commentFont: .title)
                    .padding(.horizontal, 32)
                    Spacer()
                    HStack {
                        Spacer()
                        📘DictionaryButton($📱.📚notes[ⓘndex])
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
            ForEach(📱.🆔widgetNotesID, id: \.self) {
                self.ⓝoteRow($0)
            }
        }
    }
    private func ⓝoteRow(_ ⓘd: UUID) -> some View {
        Section {
            if let ⓝote = 📱.📚notes.first(where: { $0.id == ⓘd }),
               let ⓘndex = 📱.📚notes.firstIndex(where: { $0 == ⓝote }) {
                VStack(spacing: 0) {
                    📓NoteView($📱.📚notes[ⓘndex],
                               titleFont: .title,
                               commentFont: .title3)
                    HStack {
                        Spacer()
                        📘DictionaryButton($📱.📚notes[ⓘndex])
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

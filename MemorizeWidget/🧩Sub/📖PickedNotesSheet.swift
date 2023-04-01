import SwiftUI

struct 📖PickedNotesSheet: View { //MARK: Work in progress
    @EnvironmentObject var 📱: 📱AppModel
    @State private var 🚩showDictionarySheet: Bool = false
    private var ⓝoteIndex: Int? { 📱.pickedNoteIndex }
    private var ⓝote: 📗Note? {
        guard let ⓝoteIndex else { return nil }
        return 📱.📚notes[ⓝoteIndex]
    }
    var body: some View {
        NavigationView {
            List {
                if let ⓘndex = 📱.pickedNoteIndex {
                    self.ⓟickedNoteRow()
                } else {
                    🗑️DeletedNoteView()
                }
            }
            .toolbar { 🅧DismissButton() }
        }
        .navigationViewStyle(.stack)
    }
    func ⓟickedNoteRow() -> some View {
        Section {
            VStack(spacing: 0) {
                if let ⓝoteIndex, let ⓝote {
                    📓NoteView($📱.📚notes[ⓝoteIndex])
                    HStack {
                        Spacer()
                        📗DictionaryButton(self.$🚩showDictionarySheet)
                            .modifier(📗DictionarySheet(ⓝote, self.$🚩showDictionarySheet))
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
            }
        }
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
            📱.🚩showPickedNoteSheet = false
        } label: {
            Image(systemName: "xmark.circle.fill")
                .symbolRenderingMode(.hierarchical)
        }
        .foregroundColor(.secondary)
    }
}

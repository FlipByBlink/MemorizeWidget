import SwiftUI

struct 📖NotesSheet: View { //MARK: Work in progress
    @EnvironmentObject var 📱: 📱AppModel
    @Environment(\.dismiss) var dismiss
    @State private var 🚩showDictionarySheet: Bool = false
    @FocusState private var 🔍commentFocus: Bool
    private var 🔢noteIndex: Int? {
        📱.📚notes.firstIndex { $0.id.uuidString == 📱.🆔openedNoteID }
    }
    private var 📗note: 📗Note? {
        guard let 🔢noteIndex else { return nil }
        return 📱.📚notes[🔢noteIndex]
    }
    var body: some View {
        NavigationView {
            List {
                if let 🔢noteIndex, let 📗note {
                    VStack(spacing: 16) {
                        📓NoteRow($📱.📚notes[🔢noteIndex])
                        HStack {
                            Spacer()
                            📗DictionaryButton(self.$🚩showDictionarySheet)
                                .modifier(📗DictionarySheet(📗note, self.$🚩showDictionarySheet))
                            Spacer()
                            🔍SearchButton(📗note)
                            Spacer()
                            Button(role: .destructive) {
                                📱.📚notes.remove(at: 🔢noteIndex)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                            Spacer()
                        }
                        .labelStyle(.iconOnly)
                        .buttonStyle(.plain)
                    }
                    .padding(.vertical, 24)
                } else {
                    self.ⓝoNotesView()
                }
            }
            .toolbar {
                Button {
                    self.dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .symbolRenderingMode(.hierarchical)
                }
                .foregroundColor(.secondary)
            }
        }
        .navigationViewStyle(.stack)
    }
    private func ⓝoNotesView() -> some View {
        HStack {
            Spacer()
            VStack(spacing: 24) {
                Label("Deleted.", systemImage: "checkmark")
                Image(systemName: "trash")
            }
            .imageScale(.small)
            .font(.largeTitle)
            .padding(.bottom, 48)
            Spacer()
        }
    }
}

import SwiftUI

struct 📖NotesSheet: View { //MARK: Work in progress
    @EnvironmentObject var 📱: 📱AppModel
    @Environment(\.dismiss) var dismiss
    @FocusState private var 🔍commentFocus: Bool
    private var 🔢noteIndex: Int? {
        📱.📚notes.firstIndex { $0.id.uuidString == 📱.🆔openedNoteID }
    }
    var body: some View {
        NavigationView {
            List {
                if let 🔢noteIndex {
                    📓NoteRow($📱.📚notes[🔢noteIndex], .onNotesSheet)
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

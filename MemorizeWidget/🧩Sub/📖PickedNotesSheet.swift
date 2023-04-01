import SwiftUI

struct 📖PickedNotesSheet: View { //MARK: Work in progress
    @EnvironmentObject var 📱: 📱AppModel
    @Environment(\.dismiss) var dismiss
    @FocusState private var 🔍commentFocus: Bool
    var body: some View {
        NavigationView {
            List {
                if let ⓘndex = 📱.pickedNoteIndex {
                    📓NoteRow($📱.📚notes[ⓘndex], .onNotesSheet)
                } else {
                    self.ⓓeletedNoteView()
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
    private func ⓓeletedNoteView() -> some View {
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

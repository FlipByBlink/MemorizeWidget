import SwiftUI

struct 📖PickedNotesSheet: View { //MARK: Work in progress
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        NavigationView {
            List {
                if let ⓘndex = 📱.pickedNoteIndex {
                    Section { 📓NoteRow($📱.📚notes[ⓘndex]) }
                    Section { 📓NoteRow($📱.📚notes[ⓘndex]) }
                    Section { 📓NoteRow($📱.📚notes[ⓘndex]) }
                } else {
                    🗑️DeletedNoteView()
                }
            }
            .toolbar { 🅧DismissButton() }
        }
        .navigationViewStyle(.stack)
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

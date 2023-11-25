import SwiftUI

struct 🏗️ContentView: View {
    @ObservedObject var model: 📱AppModel
    @Environment(\.dismiss) var dismiss
    @State private var note: 📗Note = .empty
    @FocusState private var titleFocus: Bool
    var body: some View {
        VStack(spacing: 12) {
            Text("New note")
                .font(.headline)
            TextField("Title", text: self.$note.title)
                .focused(self.$titleFocus)
                .font(.title2)
            TextField("Comment", text: self.$note.comment)
                .font(.title3)
                .disabled(self.note.title.isEmpty)
            HStack(spacing: 12) {
                Button(action: self.submit) {
                    Label("Add", systemImage: "checkmark")
                        .labelStyle(.iconOnly)
                        .fontWeight(.medium)
                }
                Spacer()
                Group {
                    📘DictionaryButton([self.note])
                    🔍SearchButton([self.note])
                    Button(action: self.addNewNote) {
                        Label("More new note",
                              systemImage: "plus.square.on.square")
                    }
                    .keyboardShortcut("n")
                }
                .labelStyle(.iconOnly)
                .buttonStyle(.borderless)
            }
            .disabled(self.note.title.isEmpty)
        }
        .padding()
        .frame(width: 250)
        .onSubmit(self.submit)
        .animation(.default.speed(2), value: self.note.title.isEmpty)
        .onExitCommand { self.dismiss() }
    }
    init(_ model: 📱AppModel) {
        self.model = model
    }
}

private extension 🏗️ContentView {
    private func submit() {
        guard !self.note.title.isEmpty else { return }
        self.model.notes.insert(self.note, at: 0)
        self.model.saveNotes()
        self.note = .empty
        self.dismiss()
    }
    private func addNewNote() {
        self.model.notes.insert(self.note, at: 0)
        self.model.saveNotes()
        self.note = .empty
        self.titleFocus = true
    }
}

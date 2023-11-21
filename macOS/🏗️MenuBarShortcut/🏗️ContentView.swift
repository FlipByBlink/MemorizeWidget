import SwiftUI

struct 🏗️ContentView: View {
    @ObservedObject var model: 📱AppModel
    @Environment(\.dismiss) var dismiss
    @State private var title: String = ""
    @State private var comment: String = ""
    @FocusState private var titleFocus: Bool
    var body: some View {
        VStack(spacing: 12) {
            Text("New note").font(.headline)
            TextField("Title", text: self.$title)
                .focused(self.$titleFocus)
                .font(.title2)
            TextField("Comment", text: self.$comment)
                .font(.title3)
                .disabled(self.title.isEmpty)
            HStack(spacing: 12) {
                Button(action: self.done) {
                    Label("Add", systemImage: "checkmark")
                        .labelStyle(.iconOnly)
                        .fontWeight(.medium)
                }
                Spacer()
                Group {
                    📘DictionaryButton([.init(self.title)])
                    🔍SearchButton([.init(self.title)])
                    Button(action: self.addNewNote) {
                        Label("More new note",
                              systemImage: "plus.square.on.square")
                    }
                    .keyboardShortcut("n")
                }
                .labelStyle(.iconOnly)
                .buttonStyle(.borderless)
            }
            .disabled(self.title.isEmpty)
        }
        .padding()
        .frame(width: 250)
        .onSubmit(self.done)
        .animation(.default.speed(2), value: self.title.isEmpty)
        .onExitCommand { self.dismiss() }
    }
    init(_ model: 📱AppModel) {
        self.model = model
    }
}

private extension 🏗️ContentView {
    private func done() {
        guard !self.title.isEmpty else { return }
        self.model.notes.insert(.init(self.title, self.comment), at: 0)
        self.title = ""
        self.comment = ""
        self.dismiss()
    }
    private func addNewNote() {
        self.model.notes.insert(.init(self.title, self.comment), at: 0)
        self.title = ""
        self.comment = ""
        self.titleFocus = true
    }
}

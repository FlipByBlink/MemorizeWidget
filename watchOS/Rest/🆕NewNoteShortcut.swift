import SwiftUI

struct 🆕NewNoteShortcutView: View {
    @EnvironmentObject var model: 📱AppModel
    @State private var title: String = ""
    @State private var comment: String = ""
    var body: some View {
        List {
            TextField("Title", text: self.$title)
                .font(.headline)
            TextField("Comment", text: self.$comment)
                .font(.subheadline)
                .opacity(self.title.isEmpty ? 0.33 : 1)
            self.doneButton()
        }
        .animation(.default, value: self.title.isEmpty)
    }
}

private extension 🆕NewNoteShortcutView {
    private func doneButton() -> some View {
        Section {
            Button {
                self.model.insertOnTop([.init(self.title, self.comment)])
                self.model.presentedSheetOnContentView = nil
                💥Feedback.success()
                Task { @MainActor in
                    try? await Task.sleep(for: .seconds(1))
                    self.title = ""
                    self.comment = ""
                }
            } label: {
                Label("Done", systemImage: "checkmark")
            }
            .buttonStyle(.bordered)
            .listRowBackground(Color.clear)
            .fontWeight(.semibold)
            .disabled(self.title.isEmpty)
            .foregroundStyle(self.title.isEmpty ? .tertiary : .primary)
        }
    }
}

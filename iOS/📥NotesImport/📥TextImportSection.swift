import SwiftUI

struct 📥TextImportSection: View {
    @EnvironmentObject var model: 📥NotesImportModel
    @FocusState private var textEditorFocus: Bool
    var body: some View {
        Section {
            📥SeparatorPicker()
            TextEditor(text: self.$model.pastedText)
                .focused(self.$textEditorFocus)
                .font(.subheadline.monospaced())
                .frame(height: 100)
                .padding(8)
                .overlay {
                    if self.model.pastedText.isEmpty {
                        Label("Paste the text here.",
                              systemImage: "square.and.pencil")
                        .font(.subheadline)
                        .rotationEffect(.degrees(2))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.accentColor)
                        .opacity(0.5)
                        .allowsHitTesting(false)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .keyboard) {
                        Button {
                            self.textEditorFocus = false
                        } label: {
                            Label("Done", systemImage: "keyboard.chevron.compact.down")
                        }
                    }
                }
            Button {
                self.model.importPastedText()
            } label: {
                Label("Convert this text to notes", systemImage: "text.badge.plus")
                    .padding(.vertical, 8)
            }
            .disabled(self.model.pastedText.isEmpty)
        }
        .animation(.default, value: self.model.pastedText.isEmpty)
        .alert("⚠️", isPresented: self.$model.alertError) {
            Button("OK") { self.model.caughtError = nil }
        } message: {
            self.model.caughtError?.messageText()
        }
    }
}

import SwiftUI

struct 📥TextImportSection: View {
    @EnvironmentObject var model: 📱AppModel
    @Binding var importedText: String
    @State private var pastedText: String = ""
    @FocusState private var textEditorFocus: Bool
    @State private var alertError: Bool = false
    @State private var caughtError: 📥Error?
    var body: some View {
        Section {
            📥SeparatorPicker()
            TextEditor(text: self.$pastedText)
                .focused(self.$textEditorFocus)
                .font(.subheadline.monospaced())
                .frame(height: 100)
                .padding(8)
                .overlay {
                    if self.pastedText.isEmpty {
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
                if self.model.exceedDataSize(self.pastedText) {
                    self.caughtError = .dataSizeLimitExceeded
                    self.alertError = true
                } else {
                    self.importedText = self.pastedText
                }
            } label: {
                Label("Convert this text to notes", systemImage: "text.badge.plus")
                    .padding(.vertical, 8)
            }
            .disabled(self.pastedText.isEmpty)
        }
        .animation(.default, value: self.pastedText.isEmpty)
        .alert("⚠️", isPresented: self.$alertError) {
            Button("OK") { self.caughtError = nil }
        } message: {
            self.caughtError?.messageText()
        }
    }
    init(_ importedText: Binding<String>) {
        self._importedText = importedText
    }
}

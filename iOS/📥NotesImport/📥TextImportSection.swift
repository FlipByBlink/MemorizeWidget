import SwiftUI

struct 📥TextImportSection: View {
    @EnvironmentObject var model: 📱AppModel
    @Binding var importedText: String
    @State private var pastedText: String = ""
    @FocusState private var textFieldFocus: Bool
    var body: some View {
        Section {
            📥SeparatorPicker()
            TextEditor(text: self.$pastedText)
                .focused(self.$textFieldFocus)
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
                            self.textFieldFocus = false
                        } label: {
                            Label("Done", systemImage: "keyboard.chevron.compact.down")
                        }
                    }
                }
            Button {
                self.importedText = self.pastedText
            } label: {
                Label("Convert this text to notes", systemImage: "text.badge.plus")
                    .padding(.vertical, 8)
            }
            .disabled(self.pastedText.isEmpty)
        }
        .animation(.default, value: self.pastedText.isEmpty)
    }
    init(_ importedText: Binding<String>) {
        self._importedText = importedText
    }
}

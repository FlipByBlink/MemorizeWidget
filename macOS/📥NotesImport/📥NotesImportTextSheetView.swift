import SwiftUI

struct 📥NotesImportTextSheetView: View {
    @StateObject private var model: 📥NotesImportModel = .init()
    var body: some View {
        NavigationStack(path: self.$model.navigationPath) {
            Form {
                📥SeparatorPicker()
                Section {
                    TextEditor(text: self.$model.pastedText)
                        .font(.subheadline.monospaced())
                        .frame(height: 100)
                        .padding(8)
                        .overlay {
                            if self.model.pastedText.isEmpty {
                                Label("Paste the text here.",
                                      systemImage: "square.and.pencil")
                                .font(.title3)
                                .rotationEffect(.degrees(2))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.accentColor)
                                .opacity(0.5)
                                .allowsHitTesting(false)
                            }
                        }
                }
                📥NotSupportMultiLineTextInNoteSection()
            }
            .formStyle(.grouped)
            .environmentObject(self.model)
            .navigationDestination(for: String.self) {
                📥ConvertedNotesMenu(importedText: $0)
                    .environmentObject(self.model)
            }
            .navigationTitle("Import notes")
            .toolbar {
                📥DismissButton()
                ToolbarItem(placement: .primaryAction) {
                    if self.model.navigationPath.isEmpty {
                        Button {
                            self.model.importPastedText()
                        } label: {
                            Label("Convert this text to notes",
                                  systemImage: "text.badge.plus")
                        }
                        .disabled(self.model.pastedText.isEmpty)
                    }
                }
            }
            .alert("⚠️ Error", isPresented: self.$model.alertError) {
                Button("OK") { self.model.caughtError = nil }
            } message: {
                self.model.caughtError?.messageText()
            }
        }
        .frame(width: 400, height: 360)
    }
}

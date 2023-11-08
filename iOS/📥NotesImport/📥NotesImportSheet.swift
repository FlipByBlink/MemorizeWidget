import SwiftUI

struct 📥NotesImportView: View {
    @EnvironmentObject var model: 📱AppModel
    @AppStorage("InputMode", store: .ⓐppGroup) var inputMode: 📥InputMode = .file
    @State private var importedText: String = ""
    var body: some View {
        NavigationStack {
            List {
                if self.convertedNotes.isEmpty {
                    self.inputModePicker()
                    switch self.inputMode {
                        case .file: 📥FileImportSection(self.$importedText)
                        case .text: 📥TextImportSection(self.$importedText)
                    }
                    📥InputExample()
                    Self.notSupportMultiLineTextInNoteSection()
                } else {
                    📥SeparatorPicker()
                    self.convertedNotesSection()
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    if self.convertedNotes.isEmpty { 
                        self.dismissButton()
                    } else {
                        self.cancelButton()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    if !self.convertedNotes.isEmpty { self.submitButton() }
                }
            }
            .navigationTitle("Import")
            .navigationBarTitleDisplayMode(.inline)
        }
        .animation(.default, value: self.convertedNotes)
    }
}

private extension 📥NotesImportView {
    private var convertedNotes: 📚Notes {
        📚TextConvert.decode(self.importedText, self.model.separator)
    }
    private func inputModePicker() -> some View {
        Section {
            Picker(selection: self.$inputMode) {
                Label("File", systemImage: "doc")
                    .tag(📥InputMode.file)
                Label("Text", systemImage: "text.justify.left")
                    .tag(📥InputMode.text)
            } label: {
                Label("Mode", systemImage: "tray.and.arrow.down")
            }
            .pickerStyle(.segmented)
            .listRowBackground(Color.clear)
        }
    }
    private func convertedNotesSection() -> some View {
        Section {
            ForEach(self.convertedNotes) { ⓝote in
                VStack(alignment: .leading) {
                    Text(ⓝote.title)
                    Text(ⓝote.comment)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
                .padding(.vertical, 8)
            }
        } header: {
            Text("Notes count: \(self.convertedNotes.count)")
        }
    }
    private static func notSupportMultiLineTextInNoteSection() -> some View {
        Section {
            Text("Not support multi line text in note.")
                .foregroundStyle(.secondary)
        } header: {
            Text("Directions")
        }
    }
    private func cancelButton() -> some View {
        Button(role: .cancel) {
            UINotificationFeedbackGenerator().notificationOccurred(.warning)
            self.importedText = ""
        } label: {
            Label("Cancel", systemImage: "xmark")
                .font(.body.weight(.semibold))
        }
        .tint(.red)
    }
    private func submitButton() -> some View {
        Button {
            self.model.insertOnTop(self.convertedNotes)
            self.model.presentedSheetOnContentView = nil
            UINotificationFeedbackGenerator().notificationOccurred(.success)
        } label: {
            Label("Done", systemImage: "checkmark")
                .font(.body.weight(.semibold))
        }
    }
    private func dismissButton() -> some View {
        Button {
            self.model.presentedSheetOnContentView = nil
            UISelectionFeedbackGenerator().selectionChanged()
        } label: {
            Image(systemName: "xmark.circle.fill")
                .symbolRenderingMode(.hierarchical)
                .font(.title3)
        }
        .foregroundStyle(Color.secondary)
    }
}

import SwiftUI

struct 📥NotesImportSheet: ViewModifier {
    @EnvironmentObject var model: 📱AppModel
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: self.$model.showNotesImportSheet) {
                📥NotesImportView()
            }
    }
}

private struct 📥NotesImportView: View {
    @EnvironmentObject var model: 📱AppModel
    @State private var showFileImporter: Bool = false
    @AppStorage("InputMode", store: .ⓐppGroup) var inputMode: 🄸nputMode = .file
    @AppStorage("separator", store: .ⓐppGroup) var separator: 🅂eparator = .tab
    @State private var pastedText: String = ""
    @State private var importedText: String = ""
    private var notes: 📚Notes { .convert(self.importedText, self.separator) }
    @FocusState private var textFieldFocus: Bool
    @State private var 🚨alertDataSizeLimitExceeded: Bool = false
    @State private var 🚨showErrorAlert: Bool = false
    @State private var 🚨errorMessage: String = ""
    var body: some View {
        NavigationStack {
            List {
                if self.notes.isEmpty {
                    Picker(selection: self.$inputMode) {
                        Label("File", systemImage: "doc")
                            .tag(🄸nputMode.file)
                        Label("Text", systemImage: "text.justify.left")
                            .tag(🄸nputMode.text)
                    } label: {
                        Label("Mode", systemImage: "tray.and.arrow.down")
                    }
                    self.separatorPicker()
                    switch self.inputMode {
                        case .file:
                            Section {
                                Button {
                                    self.showFileImporter.toggle()
                                } label: {
                                    Label("Import a text-encoded file", 
                                          systemImage: "folder.badge.plus")
                                    .padding(.vertical, 8)
                                }
                            }
                            📥InputExample(mode: self.$inputMode)
                        case .text:
                            Section {
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
                            📥InputExample(mode: self.$inputMode)
                    }
                    Self.notSupportMultiLineTextInNoteSection()
                } else {
                    self.separatorPicker()
                    Section {
                        ForEach(self.notes) { ⓝote in
                            VStack(alignment: .leading) {
                                Text(ⓝote.title)
                                Text(ⓝote.comment)
                                    .font(.footnote)
                                    .foregroundStyle(.secondary)
                            }
                            .padding(.vertical, 8)
                        }
                    } header: {
                        Text("Notes count: \(self.notes.count)")
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    if !self.notes.isEmpty { self.cancelButton() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    if !self.notes.isEmpty { self.submitButton() }
                }
                ToolbarItem(placement: .principal) {
                    if self.notes.isEmpty { self.dismissButton() }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .animation(.default, value: self.notes)
        .animation(.default, value: self.inputMode)
        .alert("⚠️ Data size limitation", isPresented: self.$🚨alertDataSizeLimitExceeded) {
            Button("Yes") { self.🚨alertDataSizeLimitExceeded = false }
        } message: {
            Text("Total notes data over 800kB. Please decrease notes.")
        }
        .alert("⚠️", isPresented: self.$🚨showErrorAlert) {
            Button("OK") {
                self.🚨showErrorAlert = false
                self.🚨errorMessage = ""
            }
        } message: {
            Text(self.🚨errorMessage)
        }
        .fileImporter(isPresented: self.$showFileImporter,
                      allowedContentTypes: [.text],
                      onCompletion: self.fileImportAction)
    }
}

private extension 📥NotesImportView {
    private func separatorPicker() -> some View {
        Picker(selection: self.$separator) {
            Text("Tab ␣ ")
                .tag(🅂eparator.tab)
                .accessibilityLabel("Tab")
            Text("Comma , ")
                .tag(🅂eparator.comma)
                .accessibilityLabel("Comma")
            Text("(Title only)")
                .tag(🅂eparator.titleOnly)
                .accessibilityLabel("Title only")
        } label: {
            Label("Separator", systemImage: "arrowtriangle.left.and.line.vertical.and.arrowtriangle.right")
        }
    }
    private func fileImportAction(_ ⓡesult: Result<URL, Error>) {
        do {
            let ⓤrl = try ⓡesult.get()
            if ⓤrl.startAccessingSecurityScopedResource() {
                let ⓣext = try String(contentsOf: ⓤrl)
                let ⓓataCount = 📚Notes.convert(ⓣext, self.separator).dataCount
                guard (ⓓataCount + self.model.notes.dataCount) < 800000 else {
                    self.🚨alertDataSizeLimitExceeded = true
                    return
                }
                self.importedText = ⓣext
                ⓤrl.stopAccessingSecurityScopedResource()
            }
        } catch {
            self.🚨errorMessage = error.localizedDescription
            self.🚨showErrorAlert = true
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
            self.model.insertOnTop(self.notes)
            self.model.showNotesImportSheet = false
            UINotificationFeedbackGenerator().notificationOccurred(.success)
        } label: {
            Label("Done", systemImage: "checkmark")
                .font(.body.weight(.semibold))
        }
    }
    private func dismissButton() -> some View {
        Button {
            self.model.showNotesImportSheet = false
            UISelectionFeedbackGenerator().selectionChanged()
        } label: {
            Image(systemName: "chevron.down")
                .foregroundColor(.secondary)
        }
        .accessibilityLabel("Dismiss")
    }
}

import SwiftUI

struct 📥NotesImportSheet: View {
    @EnvironmentObject var 📱: 📱AppModel
    @State private var 🚩showFileImporter: Bool = false
    @AppStorage("InputMode", store: .ⓐppGroup) var ⓘnputMode: 🄸nputMode = .file
    @AppStorage("separator", store: .ⓐppGroup) var ⓢeparator: 🅂eparator = .tab
    @State private var ⓟastedText: String = ""
    @State private var ⓘmportedText: String = ""
    private var ⓝotes: 📚Notes { .convert(self.ⓘmportedText, self.ⓢeparator) }
    @FocusState private var 🔍textFieldFocus: Bool
    @State private var 🚨alertDataSizeLimitExceeded: Bool = false
    @State private var 🚨showErrorAlert: Bool = false
    @State private var 🚨errorMessage: String = ""
    var body: some View {
        NavigationView {
            List {
                if self.ⓝotes.isEmpty {
                    Picker(selection: self.$ⓘnputMode) {
                        Label("File", systemImage: "doc")
                            .tag(🄸nputMode.file)
                        Label("Text", systemImage: "text.justify.left")
                            .tag(🄸nputMode.text)
                    } label: {
                        Label("Mode", systemImage: "tray.and.arrow.down")
                    }
                    self.ⓢeparatorPicker()
                    switch self.ⓘnputMode {
                        case .file:
                            Section {
                                Button {
                                    self.🚩showFileImporter.toggle()
                                } label: {
                                    Label("Import a text-encoded file", systemImage: "folder.badge.plus")
                                        .padding(.vertical, 8)
                                }
                            }
                            🄸nputExample(mode: self.$ⓘnputMode)
                        case .text:
                            Section {
                                TextEditor(text: self.$ⓟastedText)
                                    .focused(self.$🔍textFieldFocus)
                                    .font(.subheadline.monospaced())
                                    .frame(height: 100)
                                    .padding(8)
                                    .overlay {
                                        if self.ⓟastedText.isEmpty {
                                            Label("Paste the text here.", systemImage: "square.and.pencil")
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
                                                self.🔍textFieldFocus = false
                                            } label: {
                                                Label("Done", systemImage: "keyboard.chevron.compact.down")
                                            }
                                        }
                                    }
                                Button {
                                    self.ⓘmportedText = self.ⓟastedText
                                } label: {
                                    Label("Convert this text to notes", systemImage: "text.badge.plus")
                                        .padding(.vertical, 8)
                                }
                                .disabled(self.ⓟastedText.isEmpty)
                            }
                            .animation(.default, value: self.ⓟastedText.isEmpty)
                            🄸nputExample(mode: self.$ⓘnputMode)
                    }
                    🄽otSupportMultiLineTextInNoteSection()
                } else {
                    self.ⓢeparatorPicker()
                    Section {
                        ForEach(self.ⓝotes) { ⓝote in
                            VStack(alignment: .leading) {
                                Text(ⓝote.title)
                                Text(ⓝote.comment)
                                    .font(.footnote)
                                    .foregroundStyle(.secondary)
                            }
                            .padding(.vertical, 8)
                        }
                    } header: {
                        Text("Notes count: \(self.ⓝotes.count.description)")
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    if !self.ⓝotes.isEmpty {
                        Button(role: .cancel) {
                            UINotificationFeedbackGenerator().notificationOccurred(.warning)
                            self.ⓘmportedText = ""
                        } label: {
                            Label("Cancel", systemImage: "xmark")
                                .font(.body.weight(.semibold))
                        }
                        .tint(.red)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    if !self.ⓝotes.isEmpty {
                        Button {
                            📱.🚩showNotesImportSheet = false
                            UINotificationFeedbackGenerator().notificationOccurred(.success)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                📱.insertOnTop(self.ⓝotes)
                                self.ⓘmportedText = ""
                            }
                        } label: {
                            Label("Done", systemImage: "checkmark")
                                .font(.body.weight(.semibold))
                        }
                    }
                }
                ToolbarItem(placement: .principal) {
                    if self.ⓝotes.isEmpty {
                        Button {
                            self.🚨alertDataSizeLimitExceeded = false
                            UISelectionFeedbackGenerator().selectionChanged()
                        } label: {
                            Image(systemName: "chevron.down")
                                .foregroundColor(.secondary)
                        }
                        .accessibilityLabel("Dismiss")
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .animation(.default, value: self.ⓝotes)
        .animation(.default, value: self.ⓘnputMode)
        .alert("⚠️ Data size limitation", isPresented: self.$🚨alertDataSizeLimitExceeded) {
            Button("Yes") {
                self.🚨alertDataSizeLimitExceeded = false
            }
        } message: {
            Text("Notes data over 300kb. The data may exceed size limitation(1mb). Please decrease notes.")
        }
        .alert("⚠️", isPresented: self.$🚨showErrorAlert) {
            Button("OK") {
                self.🚨showErrorAlert = false
                self.🚨errorMessage = ""
            }
        } message: {
            Text(self.🚨errorMessage)
        }
        .fileImporter(isPresented: self.$🚩showFileImporter,
                      allowedContentTypes: [.text],
                      onCompletion: self.ⓕileImportAction)
    }
    private func ⓢeparatorPicker() -> some View {
        Picker(selection: self.$ⓢeparator) {
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
    private func ⓕileImportAction(_ ⓡesult: Result<URL, Error>) {
        do {
            let ⓤrl = try ⓡesult.get()
            if ⓤrl.startAccessingSecurityScopedResource() {
                let ⓣext = try String(contentsOf: ⓤrl)
                guard let ⓓata = ⓣext.data(using: .utf8), ⓓata.count < 300000 else {
                    self.🚨alertDataSizeLimitExceeded = true
                    return
                }
                self.ⓘmportedText = ⓣext
                ⓤrl.stopAccessingSecurityScopedResource()
            }
        } catch {
            self.🚨errorMessage = error.localizedDescription
            self.🚨showErrorAlert = true
        }
    }
}

enum 🄸nputMode: String {
    case file, text
}

private struct 🄸nputExample: View {
    @Binding var mode: 🄸nputMode
    var body: some View {
        Section {
            switch self.mode {
                case .file:
                    HStack {
                        Image("sample_numbers")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(12)
                            .shadow(radius: 2)
                        Image(systemName: "arrow.right")
                            .font(.title2.weight(.semibold))
                        Image("sample_importedNotes")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(12)
                            .shadow(radius: 2)
                    }
                    .frame(maxHeight: 220)
                    .padding(.horizontal, 8)
                    .padding(.vertical)
                    Image("numbers_csv_tsv_export")
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(12)
                        .frame(maxHeight: 200)
                        .shadow(radius: 2)
                        .padding()
                    Image("sample_txt_macTextEdit")
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(12)
                        .frame(maxHeight: 200)
                        .shadow(radius: 2)
                        .padding()
                case .text:
                    HStack {
                        Image("sample_appleNotes")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(12)
                            .shadow(radius: 2)
                        Image(systemName: "arrow.right")
                            .font(.title2.weight(.semibold))
                        Image("sample_importedNotes")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(12)
                            .shadow(radius: 2)
                    }
                    .frame(maxHeight: 200)
                    .padding(.horizontal, 8)
                    .padding(.vertical)
            }
        } header: {
            Text("Example")
        }
    }
}

private struct 🄽otSupportMultiLineTextInNoteSection: View {
    var body: some View {
        Section {
            Text("Not support multi line text in note.")
                .foregroundStyle(.secondary)
        } header: {
            Text("Directions")
        }
    }
}

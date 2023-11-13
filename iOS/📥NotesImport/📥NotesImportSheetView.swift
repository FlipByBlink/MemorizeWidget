import SwiftUI

struct 📥NotesImportSheetView: View {
    @StateObject private var model: 📥NotesImportModel = .init()
    var body: some View {
        NavigationStack(path: self.$model.navigationPath) {
            List {
                self.inputModePicker()
                switch self.model.inputMode {
                    case .file: 📥FileImportSection()
                    case .text: 📥TextImportSection()
                }
                📥InputExample()
                Self.notSupportMultiLineTextInNoteSection()
            }
            .environmentObject(self.model)
            .navigationDestination(for: String.self) {
                📥ConvertedNotesMenu(importedText: $0)
                    .environmentObject(self.model)
            }
            .navigationTitle("Import notes")
            .toolbar { 📰DismissButton() }
        }
    }
}

private extension 📥NotesImportSheetView {
    private func inputModePicker() -> some View {
        Section {
            Picker(selection: self.$model.inputMode) {
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
    private static func notSupportMultiLineTextInNoteSection() -> some View {
        Section {
            Text("Not support multi line text in note.")
                .foregroundStyle(.secondary)
        } header: {
            Text("Directions")
        }
    }
}

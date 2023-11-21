import SwiftUI

struct 📥ConvertedNotesMenu: View {
    @EnvironmentObject var model: 📥NotesImportModel
    var importedText: String
    var body: some View {
        List {
            📥SeparatorPicker()
            self.convertedNotesSection()
        }
        .navigationTitle("Convert result")
        .toolbar {
            Self.SubmitButton(self.convertedNotes)
        }
    }
}

private extension 📥ConvertedNotesMenu {
    private var convertedNotes: 📚Notes {
        📚TextConvert.decode(self.importedText, self.model.separator)
    }
    private func convertedNotesSection() -> some View {
        Section {
            ForEach(self.convertedNotes) { ⓝote in
                VStack(alignment: .leading) {
                    Text(ⓝote.title)
                        .font(.headline)
                    Text(ⓝote.comment)
                        .font(.footnote)
                }
                .foregroundStyle(.secondary)
                .padding(.vertical, 8)
            }
        } header: {
            Text("Notes count: \(self.convertedNotes.count)")
        }
    }
    private struct SubmitButton: ToolbarContent {
        @EnvironmentObject var model: 📱AppModel
        var convertedNotes: 📚Notes
        var body: some ToolbarContent {
            ToolbarItem(placement: .primaryAction) {
                Button {
//                    self.model.submitNotesImport(self.convertedNotes)
                } label: {
                    Label("Apply", systemImage: "checkmark")
                }
            }
        }
        init(_ convertedNotes: 📚Notes) {
            self.convertedNotes = convertedNotes
        }
    }
}

import SwiftUI

struct 📥ConvertedNotesMenu: View {
    @EnvironmentObject var appModel: 📱AppModel
    @EnvironmentObject var model: 📥NotesImportModel
    var importedText: String
    var body: some View {
        List {
            📥SeparatorPicker()
            self.convertedNotesSection()
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) { self.cancelButton() }
            ToolbarItem(placement: .topBarTrailing) { self.submitButton() }
        }
        .navigationBarBackButtonHidden()
    }
}

private extension 📥ConvertedNotesMenu {
    var convertedNotes: 📚Notes {
        📚TextConvert.decode(self.importedText, self.model.separator)
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
    private func cancelButton() -> some View {
        Button(role: .cancel) {
            self.model.cancel()
        } label: {
            Image(systemName: "xmark")
                .font(.title3.weight(.heavy))
        }
        .accessibilityLabel("Cancel")
        .tint(.red)
    }
    private func submitButton() -> some View {
        Button {
            self.appModel.insertOnTop(self.convertedNotes)
            self.appModel.presentedSheetOnContentView = nil
            UINotificationFeedbackGenerator().notificationOccurred(.success)
        } label: {
            Image(systemName: "checkmark")
                .font(.title3.weight(.heavy))
        }
    }
}

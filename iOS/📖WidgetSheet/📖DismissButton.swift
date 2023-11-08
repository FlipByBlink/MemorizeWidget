import SwiftUI

struct 📖DismissButton: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        Button {
            self.model.presentedSheetOnContentView = nil
            UISelectionFeedbackGenerator().selectionChanged()
        } label: {
            Image(systemName: "xmark.circle.fill")
                .symbolRenderingMode(.hierarchical)
                .font(.title3)
        }
        .foregroundColor(.secondary)
        .keyboardShortcut(.cancelAction)
    }
}

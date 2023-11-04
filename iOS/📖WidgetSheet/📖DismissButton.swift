import SwiftUI

struct 📖DismissButton: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        Button {
            self.model.widgetState.showSheet = false
            UISelectionFeedbackGenerator().selectionChanged()
        } label: {
            Image(systemName: "xmark.circle.fill")
                .symbolRenderingMode(.hierarchical)
        }
        .foregroundColor(.secondary)
        .keyboardShortcut(.cancelAction)
    }
}

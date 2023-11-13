import SwiftUI

//MARK: For sheet on ContentView
struct 📰DismissButton: ToolbarContent {
    @EnvironmentObject var model: 📱AppModel
    var body: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                self.model.presentedSheetOnContentView = nil
                UISelectionFeedbackGenerator().selectionChanged()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .symbolRenderingMode(.hierarchical)
                    .font(.title3)
                    .foregroundStyle(Color.secondary)
            }
            .keyboardShortcut(.cancelAction)
        }
    }
}

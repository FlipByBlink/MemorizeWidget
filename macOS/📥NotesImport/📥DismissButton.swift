import SwiftUI

struct 📥DismissButton: ToolbarContent {
    @EnvironmentObject var model: 📱AppModel
    var body: some ToolbarContent {
        ToolbarItem(placement: .automatic) {
            Button("Dismiss", role: .cancel) {
                self.model.presentedSheetOnContentView = nil
            }
            .foregroundStyle(.secondary)
        }
    }
}

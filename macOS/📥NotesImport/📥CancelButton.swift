import SwiftUI

struct 📥CancelButton: ToolbarContent {
    @EnvironmentObject var model: 📱AppModel
    var body: some ToolbarContent {
        ToolbarItem(placement: .automatic) {
            Button("Cancel", role: .cancel) {
                self.model.presentedSheetOnContentView = nil
            }
            .foregroundStyle(.secondary)
        }
    }
}

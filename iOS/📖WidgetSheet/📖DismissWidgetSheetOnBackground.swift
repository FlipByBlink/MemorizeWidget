import SwiftUI

struct 📖DismissWidgetSheetOnBackground: ViewModifier {
    @EnvironmentObject var model: 📱AppModel
    @Environment(\.scenePhase) var scenePhase
    func body(content: Content) -> some View {
        content
            .onChange(of: self.scenePhase) {
                self.model.dismissWidgetSheetOnBackground($0)
            }
    }
}

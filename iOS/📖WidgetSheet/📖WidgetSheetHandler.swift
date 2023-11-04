import SwiftUI

struct 📖WidgetSheetHandler: ViewModifier {
    @EnvironmentObject var appModel: 📱AppModel
    @EnvironmentObject var inAppPurchaseModel: 🛒InAppPurchaseModel
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: self.$appModel.widgetState.showSheet) {
                📖WidgetSheetView()
                    .environmentObject(self.appModel)
                    .environmentObject(self.inAppPurchaseModel)
            }
    }
}

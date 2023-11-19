import SwiftUI

struct 📣ADSheet: ViewModifier {
    @EnvironmentObject var appModel: 📱AppModel
    @State private var targetApp: 📣ADTargetApp = .pickUpAppWithout(.FlipByBlink)
    @State private var showSheet: Bool = false
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: self.$showSheet) {
                📣ADContent(self.targetApp, second: 5)
                    .environmentObject(self.appModel.inAppPurchaseModel)
            }
            .task {
                try? await Task.sleep(for: .seconds(0.5))
                if self.appModel.inAppPurchaseModel.checkToShowADSheet() { self.showSheet = true }
            }
    }
}

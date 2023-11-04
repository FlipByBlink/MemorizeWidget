import SwiftUI

struct 📣ADSheet: ViewModifier {
    @EnvironmentObject var model: 🛒InAppPurchaseModel
    @State private var targetApp: 📣ADTargetApp = .pickUpAppWithout(.MemorizeWidget)
    @State private var showSheet: Bool = false
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: self.$showSheet) {
                📣ADView(self.targetApp, second: 10)
                    .environmentObject(self.model)
            }
            .task {
                try? await Task.sleep(for: .seconds(1))
                if self.model.checkToShowADSheet() {
                    self.showSheet = true
                }
            }
    }
}

import SwiftUI

struct 📣ADContentView: View {
    @EnvironmentObject var model: 🛒InAppPurchaseModel
    @State private var targetApp: 📣ADTargetApp = .pickUpAppWithout(.MemorizeWidget)
    var body: some View {
        📣ADView(self.targetApp, second: 10)
            .environmentObject(self.model)
    }
}

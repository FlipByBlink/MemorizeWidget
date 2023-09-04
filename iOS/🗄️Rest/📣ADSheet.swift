import SwiftUI

struct 📣ADSheet: ViewModifier {
    @EnvironmentObject var 🛒: 🛒InAppPurchaseModel
    @State private var targetApp: 📣ADTargetApp = .pickUpAppWithout(.MemorizeWidget)
    @State private var showSheet: Bool = false
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: self.$showSheet) {
                📣ADView(self.targetApp, second: 10)
                    .environmentObject(🛒)
            }
            .task {
                try? await Task.sleep(for: .seconds(1))
                if 🛒.checkToShowADSheet() {
                    self.showSheet = true
                }
            }
    }
}

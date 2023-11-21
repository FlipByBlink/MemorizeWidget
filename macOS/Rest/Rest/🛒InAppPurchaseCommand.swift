import SwiftUI

struct 🛒InAppPurchaseCommand: Commands {
    @Environment(\.openWindow) var openWindow
    var body: some Commands {
        CommandGroup(before: .appVisibility) {
            Button(String(localized: "In-App Purchase", table: "🌐AD&InAppPurchase")) {
                self.openWindow(id: "InAppPurchase")
            }
            Divider()
        }
    }
}

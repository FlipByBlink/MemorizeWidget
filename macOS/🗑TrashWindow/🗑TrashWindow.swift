import SwiftUI

struct 🗑TrashWindow: Scene {
    var body: some Scene {
        Window("Trash", id: "trash") {
            🗑ContentView()
                .frame(minWidth: Self.size.width,
                       minHeight: Self.size.height)
        }
        .defaultSize(width: Self.size.width,
                     height: Self.size.height)
        .defaultPosition(.init(x: 0.75, y: 0.5))
    }
}

private extension 🗑TrashWindow {
    private static var size: (width: CGFloat, height: CGFloat) {
        (380, 240)
    }
}

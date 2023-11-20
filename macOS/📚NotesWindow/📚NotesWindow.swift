import SwiftUI

struct 📚NotesWindow: Scene {
    var body: some Scene {
        Window("Notes", id: "notes") {
            📚ContentView()
                .frame(minWidth: Self.size.width,
                       minHeight: Self.size.height)
        }
        .defaultSize(width: Self.size.width,
                     height: Self.size.height)
    }
}

private extension 📚NotesWindow {
    private static var size: (width: CGFloat, height: CGFloat) {
        (380, 240)
    }
}

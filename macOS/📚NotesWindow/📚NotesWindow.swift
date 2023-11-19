import SwiftUI

struct 📚NotesWindow: Scene {
    var body: some Scene {
        Window("Notes", id: "notes") {
            📚NotesListPanel()
                .frame(minWidth: Self.windowSize.width,
                       minHeight: Self.windowSize.height)
        }
        .defaultSize(width: Self.windowSize.width,
                     height: Self.windowSize.height)
    }
}

private extension 📚NotesWindow {
    private static var windowSize: (width: CGFloat, height: CGFloat) {
        (380, 240)
    }
}

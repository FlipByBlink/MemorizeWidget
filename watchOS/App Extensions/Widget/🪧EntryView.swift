import SwiftUI

struct 🪧EntryView: View {
    private var info: 🪧WidgetInfo
    var body: some View {
        Group {
            if self.info.targetedNotes.isEmpty {
                🪧PlaceholderView()
            } else {
                🪧AccessoryWidgetView(self.info)
            }
        }
        .widgetURL(self.info.url)
        .modifier(🪧ContainerBackground())
    }
    init(_ ⓔntry: 🪧WidgetEntry) {
        self.info = ⓔntry.info
    }
}

import SwiftUI

struct 🪧EntryView: View {
    private var ⓘnfo: 🪧WidgetInfo
    var body: some View {
        Group {
            if self.ⓘnfo.targetedNotes.isEmpty {
                Image(systemName: "book.closed")
                    .foregroundStyle(.tertiary)
            } else {
                🪧AccessoryWidgetView(self.ⓘnfo)
            }
        }
        .widgetURL(self.ⓘnfo.url)
        .modifier(🪧ContainerBackground())
    }
    init(_ ⓔntry: 🪧WidgetEntry) {
        self.ⓘnfo = ⓔntry.info
    }
}

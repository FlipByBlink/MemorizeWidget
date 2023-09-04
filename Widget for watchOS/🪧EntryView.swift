import SwiftUI
import WidgetKit

struct 🪧EntryView: View {
    private var ⓘnfo: 🪧WidgetInfo
    private var ⓝotes: [📗Note] { self.ⓘnfo.targetedNotes }
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

import SwiftUI

struct 🪧EntryView: View {
    private var ⓘnfo: 🪧WidgetInfo
    @Environment(\.widgetFamily) var widgetFamily
    var body: some View {
        Group {
            if !self.ⓘnfo.targetedNotes.isEmpty {
                switch self.widgetFamily {
                    case .systemSmall, .systemMedium, .systemLarge:
                        🪧SystemWidgetView(self.ⓘnfo)
                    case .accessoryInline, .accessoryCircular, .accessoryRectangular:
                        🪧AccessoryWidgetView(self.ⓘnfo)
                    default:
                        Text(verbatim: "🐛")
                }
            } else {
                🪧NoNoteView()
            }
        }
        .widgetURL(self.ⓘnfo.url)
        .modifier(🪧ContainerBackground())
    }
    init(_ ⓔntry: 🪧WidgetEntry) {
        self.ⓘnfo = ⓔntry.info
    }
}

import SwiftUI

struct 🪧EntryView: View {
    private var info: 🪧WidgetInfo
    @Environment(\.widgetFamily) var widgetFamily
    var body: some View {
        Group {
            if self.info.targetedNotes.isEmpty {
                🪧NoNoteView()
            } else {
                switch self.widgetFamily {
                    case .systemSmall, .systemMedium, .systemLarge:
                        🪧SystemWidgetView(self.info)
                    case .accessoryInline, .accessoryCircular, .accessoryRectangular:
                        🪧AccessoryWidgetView(self.info)
                    default:
                        Text(verbatim: "BUG")
                }
            }
        }
        .widgetURL(self.info.url)
        .modifier(🪧ContainerBackground())
    }
    init(_ ⓔntry: 🪧WidgetEntry) {
        self.info = ⓔntry.info
    }
}

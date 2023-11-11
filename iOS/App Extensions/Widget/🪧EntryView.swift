import SwiftUI

struct 🪧EntryView: View {
    private var tag: 🪧Tag
    @Environment(\.widgetFamily) var widgetFamily
    var body: some View {
        Group {
            if self.tag.loadTargetedNotes().isEmpty {
                🪧NoNoteView()
            } else {
                switch self.widgetFamily {
                    case .systemSmall, .systemMedium, .systemLarge:
                        🪧SystemWidgetView(self.tag)
                    case .accessoryInline, .accessoryCircular, .accessoryRectangular:
                        🪧AccessoryWidgetView(self.tag)
                    default:
                        Text(verbatim: "BUG")
                }
            }
        }
        .widgetURL(self.tag.url)
        .modifier(🪧ContainerBackground())
    }
    init(_ ⓔntry: 🪧Entry) {
        self.tag = ⓔntry.tag
    }
}

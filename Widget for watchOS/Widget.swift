import WidgetKit
import SwiftUI

@main
struct WidgetForWatchOS: WidgetBundle {
    var body: some Widget {
        🄼WComplication()
        🆕NewNoteShortcutWidget()
    }
}

private struct 🄼WComplication: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "MWComplication", provider: 🕒TimelineProvider()) { ⓔntry in
            🕒EntryView(ⓔntry)
        }
        .configurationDisplayName("MemorizeWidget")
        .description("Show a note.")
    }
}

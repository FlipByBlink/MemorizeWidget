import WidgetKit
import SwiftUI

@main
struct WidgetForWatchOS: WidgetBundle {
    var body: some Widget {
        🪧Widget()
        🪧NewNoteShortcutWidget()
    }
}

private struct 🪧Widget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "MWComplication", provider: 🪧Provider()) { ⓔntry in
            🪧EntryView(ⓔntry)
        }
        .configurationDisplayName("MemorizeWidget")
        .description("Show a note.")
    }
}

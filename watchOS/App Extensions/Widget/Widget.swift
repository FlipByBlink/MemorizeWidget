import WidgetKit
import SwiftUI

@main
struct WatchOSWidgetBundle: WidgetBundle {
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
        .configurationDisplayName("Notes")
        .description("Show a note.")
    }
}

import WidgetKit
import SwiftUI

@main
struct WatchOSWidgetBundle: WidgetBundle {
    var body: some Widget {
        Self.PrimaryWidget()
        🪧NewNoteShortcutWidget()
    }
}

private extension WatchOSWidgetBundle {
    private struct PrimaryWidget: Widget {
        var body: some WidgetConfiguration {
            StaticConfiguration(kind: "MWComplication", provider: 🪧Provider()) { ⓔntry in
                switch ⓔntry.info {
                    case .widgetPlaceholder: 🪧PlaceholderView()
                    default: 🪧EntryView(ⓔntry)
                }
            }
            .configurationDisplayName("Notes")
            .description("Show a note.")
        }
    }
}

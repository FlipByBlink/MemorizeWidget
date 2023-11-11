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
            StaticConfiguration(kind: "MWComplication",
                                provider: 🪧Provider(kind: .primary)) { ⓔntry in
                switch ⓔntry.phase {
                    case .placeholder: 🪧PlaceholderView()
                    default: 🪧EntryView(ⓔntry)
                }
            }
            .configurationDisplayName("Notes")
            .description("Show a note.")
        }
    }
}

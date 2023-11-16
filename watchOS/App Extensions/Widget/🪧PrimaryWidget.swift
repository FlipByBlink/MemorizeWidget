import SwiftUI
import WidgetKit

struct 🪧PrimaryWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "MWComplication", provider: 🪧Provider(kind: .primary)) {
            if $0.phase == .placeholder {
                🪧PlaceholderView()
            } else {
                🪧EntryView($0)
            }
        }
        .configurationDisplayName("Notes")
        .description("Show a note.")
    }
}

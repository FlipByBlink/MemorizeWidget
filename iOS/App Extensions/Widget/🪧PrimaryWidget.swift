import WidgetKit
import SwiftUI

struct 🪧PrimaryWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "main", provider: 🪧Provider(kind: .primary)) {
            if $0.phase == .placeholder {
                🪧PlaceholderView()
            } else {
                🪧EntryView($0)
            }
        }
        .configurationDisplayName("MemorizeWidget")
        .description("Show a note.")
        .contentMarginsDisabled()
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge, .systemExtraLarge,
                            .accessoryInline, .accessoryRectangular, .accessoryCircular])
    }
}

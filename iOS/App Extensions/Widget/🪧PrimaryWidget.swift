import WidgetKit
import SwiftUI

struct 🪧PrimaryWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "main",
                            provider: 🪧Provider(kind: .primary)) { ⓔntry in
            switch ⓔntry.phase {
                case .placeholder: 🪧PlaceholderView()
                case .snapshot, .inTimeline: 🪧EntryView(ⓔntry)
            }
        }
        .configurationDisplayName("MemorizeWidget")
        .description("Show a note.")
        .contentMarginsDisabled()
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge,
                            .accessoryInline, .accessoryRectangular, .accessoryCircular])
    }
}

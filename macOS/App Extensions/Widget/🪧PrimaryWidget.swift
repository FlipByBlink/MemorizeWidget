import WidgetKit
import SwiftUI

struct 🪧PrimaryWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "primary", provider: 🪧Provider(kind: .primary)) {
            if $0.phase == .placeholder {
                🪧PlaceholderView()
            } else {
                🪧EntryView($0)
            }
        }
        .configurationDisplayName("MemorizeWidget")
        .description("Show a note.")
        .contentMarginsDisabled()
        .supportedFamilies(Self.family)
    }
}

private extension 🪧PrimaryWidget {
    private static var family: [WidgetFamily] {
        if #available(macOS 14.0, *) {
            [.systemSmall, .systemMedium, .systemLarge, .systemExtraLarge]
        } else {
            [.systemSmall, .systemMedium, .systemLarge]
        }
    }
}

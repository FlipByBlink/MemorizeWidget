import WidgetKit
import SwiftUI

struct 🪧SubWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "sub",
                            provider: 🪧Provider(kind: .sub)) { ⓔntry in
            switch ⓔntry.phase {
                case .placeholder: 🪧PlaceholderView()
                case .snapshot, .inTimeline: 🪧EntryView(ⓔntry)
            }
        }
        .configurationDisplayName("Sub widget")
        .description("This is spare widget for the purpose of second widget and random-mode")
        .contentMarginsDisabled()
        .supportedFamilies(Self.families)
    }
}

private extension 🪧SubWidget {
    private static var families: [WidgetFamily] {
        switch UIDevice.current.userInterfaceIdiom {
            case .phone: [.accessoryRectangular]
            case .pad: [.systemLarge]
            default: []
        }
    }
}

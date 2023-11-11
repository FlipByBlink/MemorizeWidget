import WidgetKit
import SwiftUI

struct 🪧SubWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "sub",
                            provider: 🪧Provider(kind: .sub)) {
            if $0.phase == .placeholder {
                🪧PlaceholderView()
            } else {
                🪧EntryView($0)
            }
        }
        .configurationDisplayName("Sub widget")
        .description("This is spare widget for the purpose of second widget")
        .contentMarginsDisabled()
        .supportedFamilies(Self.families)
    }
}

private extension 🪧SubWidget {
    private static var families: [WidgetFamily] {
        var ⓥalue: [WidgetFamily] = [.accessoryCircular, .accessoryRectangular]
#if os(iOS)
        ⓥalue.append(contentsOf: [.systemSmall, .systemMedium])
        if UIDevice.current.userInterfaceIdiom == .pad {
            ⓥalue.append(.systemLarge)
        }
#elseif os(watchOS)
        ⓥalue.append(.accessoryCorner)
#endif
        return ⓥalue
    }
}

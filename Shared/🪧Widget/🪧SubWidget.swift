import WidgetKit
import SwiftUI

struct 🪧SubWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "sub", provider: 🪧Provider(kind: .sub)) {
            🪧EntryView($0)
        }
        .configurationDisplayName("Sub widget")
        .description("This is spare widget for the purpose of second widget")
        .contentMarginsDisabled()
        .supportedFamilies(Self.families)
    }
}

private extension 🪧SubWidget {
    private static var families: [WidgetFamily] {
        var ⓥalue: [WidgetFamily] = []
#if os(iOS)
        ⓥalue.append(contentsOf: [.accessoryCircular, .accessoryRectangular,
                                  .systemSmall, .systemMedium])
        if UIDevice.current.userInterfaceIdiom == .pad {
            ⓥalue.append(contentsOf: [.systemLarge, .systemExtraLarge])
        }
#elseif os(watchOS)
        ⓥalue.append(contentsOf: [.accessoryCircular, .accessoryRectangular, .accessoryCorner])
#elseif os(macOS)
        ⓥalue.append(contentsOf: [.systemSmall, .systemMedium, .systemLarge])
        if #available(macOS 14.0, *) { ⓥalue.append(.systemExtraLarge) }
#endif
        return ⓥalue
    }
}

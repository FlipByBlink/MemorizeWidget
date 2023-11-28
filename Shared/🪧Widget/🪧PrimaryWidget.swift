import WidgetKit
import SwiftUI

struct 🪧PrimaryWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: Self.kind, provider: 🪧Provider(kind: .primary)) {
            if $0.phase == .placeholder {
                🪧PlaceholderView()
            } else {
                🪧EntryView($0)
            }
        }
        .configurationDisplayName(Self.configurationDisplayName)
        .description("Show a note.")
        .contentMarginsDisabled() //TODO: watchOSでおかしくならないか要確認
        .supportedFamilies(Self.supportedFamilies)
    }
}

private extension 🪧PrimaryWidget {
    private static var kind: String {
#if os(iOS)
        "main"
#elseif os(watchOS)
        "MWComplication"
#elseif os(macOS)
        "primary"
#endif
    }
    private static var configurationDisplayName: LocalizedStringKey {
#if os(iOS) || os(macOS)
        "MemorizeWidget"
#elseif os(watchOS)
        "Notes"
#endif
    }
    private static var supportedFamilies: [WidgetFamily] {
#if os(iOS)
        [.systemSmall, .systemMedium, .systemLarge, .systemExtraLarge,
         .accessoryInline, .accessoryRectangular, .accessoryCircular]
#elseif os(watchOS)
        [.accessoryInline, .accessoryRectangular, .accessoryCircular, .accessoryCorner]
#elseif os(macOS)
        if #available(macOS 14.0, *) {
            [.systemSmall, .systemMedium, .systemLarge, .systemExtraLarge]
        } else {
            [.systemSmall, .systemMedium, .systemLarge]
        }
#endif
    }
}

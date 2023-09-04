import WidgetKit
import SwiftUI

@main
struct WidgetForIOS: WidgetBundle {
    var body: some Widget {
        🪧MWWidget()
        🆕NewNoteShortcutWidget()
        🪧MWWidgetSub()
    }
}

private struct 🪧MWWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "main", provider: 🕒TimelineProvider()) { ⓔntry in
            🕒EntryView(ⓔntry)
        }
        .configurationDisplayName("MemorizeWidget")
        .description("Show a note.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge,
                            .accessoryInline, .accessoryRectangular, .accessoryCircular])
    }
}

//SubWidget
private struct 🪧MWWidgetSub: Widget {
    private var ⓕamilies: [WidgetFamily] = []
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "sub", provider: 🕒TimelineProvider()) { ⓔntry in
            🕒EntryView(ⓔntry)
        }
        .configurationDisplayName("Sub widget")
        .description("This is spare widget for the purpose of second widget and random-mode")
        .supportedFamilies(self.ⓕamilies)
    }
    init() {
        if UIDevice.current.userInterfaceIdiom == .pad {
#if !targetEnvironment(macCatalyst)
            self.ⓕamilies.append(contentsOf: [.systemLarge])
#endif
        }
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.ⓕamilies.append(contentsOf: [.accessoryRectangular])
        }
    }
}

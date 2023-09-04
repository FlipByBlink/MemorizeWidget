import WidgetKit
import SwiftUI

@main
struct WidgetForIOS: WidgetBundle {
    var body: some Widget {
        🪧Widget()
        🪧NewNoteShortcutWidget()
        🪧WidgetSub()
    }
}

private struct 🪧Widget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "main", provider: 🪧Provider()) { ⓔntry in
            🪧EntryView(ⓔntry)
        }
        .configurationDisplayName("MemorizeWidget")
        .description("Show a note.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge,
                            .accessoryInline, .accessoryRectangular, .accessoryCircular])
    }
}

//SubWidget
private struct 🪧WidgetSub: Widget {
    private var ⓕamilies: [WidgetFamily] = []
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "sub", provider: 🪧Provider()) { ⓔntry in
            🪧EntryView(ⓔntry)
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

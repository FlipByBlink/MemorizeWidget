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
        .contentMarginsDisabled()
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge,
                            .accessoryInline, .accessoryRectangular, .accessoryCircular])
    }
}

private struct 🪧WidgetSub: Widget {
    private var ⓕamilies: [WidgetFamily] = []
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "sub", provider: 🪧Provider()) { ⓔntry in
            🪧EntryView(ⓔntry)
        }
        .configurationDisplayName("Sub widget")
        .description("This is spare widget for the purpose of second widget and random-mode")
        .contentMarginsDisabled()
        .supportedFamilies(self.ⓕamilies)
    }
    init() {
        switch UIDevice.current.userInterfaceIdiom {
            case .phone: self.ⓕamilies.append(contentsOf: [.accessoryRectangular])
            case .pad: self.ⓕamilies.append(contentsOf: [.systemLarge])
            default: break
        }
    }
}

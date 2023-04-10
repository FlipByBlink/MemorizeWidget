import WidgetKit
import SwiftUI

@main
struct MWWidgetBundle: WidgetBundle {
    var body: some Widget {
        🖼MWWidget()
        🆕NewNoteShortcutWidget()
        🖼MWWidgetSub()
    }
}

private struct 🖼MWWidget: Widget {
    private var ⓕamilies: [WidgetFamily] = [.systemSmall, .systemMedium, .systemLarge]
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "main", provider: 🕒TimelineProvider()) { ⓔntry in
            🅆idgetEntryView(ⓔntry)
        }
        .configurationDisplayName("MemorizeWidget")
        .description("Show a note.")
        .supportedFamilies(self.ⓕamilies)
    }
    init() {
        if #available(iOS 16.0, *) {
            self.ⓕamilies.append(contentsOf: [.accessoryInline, .accessoryRectangular, .accessoryCircular])
        }
    }
}

//SubWidget
private struct 🖼MWWidgetSub: Widget {
    private var ⓕamilies: [WidgetFamily] = []
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "sub", provider: 🕒TimelineProvider()) { ⓔntry in
            🅆idgetEntryView(ⓔntry)
        }
        .configurationDisplayName("Sub widget")
        .description("This is spare widget for the purpose of second widget and random-mode")
        .supportedFamilies(self.ⓕamilies)
    }
    init() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            self.ⓕamilies.append(contentsOf: [.systemLarge])
        }
        if UIDevice.current.userInterfaceIdiom == .phone {
            if #available(iOS 16.0, *) {
                self.ⓕamilies.append(contentsOf: [.accessoryRectangular])
            }
        }
    }
}

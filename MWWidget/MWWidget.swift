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

struct 🖼MWWidget: Widget {
    private var ⓕamilies: [WidgetFamily] = [.systemSmall, .systemMedium]
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "main", provider: 🤖TimelineProvider()) { ⓔntry in
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

struct 🖼MWWidgetSub: Widget {
    private var ⓕamilies: [WidgetFamily] = [.systemSmall, .systemMedium]
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "sub", provider: 🤖TimelineProvider()) { ⓔntry in
            🅆idgetEntryView(ⓔntry)
        }
        .configurationDisplayName("Sub widget")
        .description("This is spare widget for the purpose of second widget and random-mode")
        .supportedFamilies(self.ⓕamilies)
    }
    init() {
        if #available(iOS 16.0, *) {
            self.ⓕamilies.append(contentsOf: [.accessoryRectangular, .accessoryCircular])
        }
    }
}

struct 🤖TimelineProvider: TimelineProvider {
    func placeholder(in context: Context) -> 🕒WidgetEntry {
        🕒WidgetEntry(.now, .singleNote(📚Notes.sample.first!.id))
    }
    func getSnapshot(in context: Context, completion: @escaping (🕒WidgetEntry) -> ()) {
        completion(.generateEntry(.now, context.family))
    }
    func getTimeline(in context: Context, completion: @escaping (Timeline<🕒WidgetEntry>) -> ()) {
        completion(🕒WidgetEntry.generateTimeline(context.family))
    }
}

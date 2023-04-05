import SwiftUI
import WidgetKit

struct 🆕NewNoteShortcutWidget: Widget {
    private var ⓕamilies: [WidgetFamily] = []
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "NewNoteShortcut", provider: 🤖NewNoteShortcutProvider()) { _ in
            🄽ewNoteShortcutView()
        }
        .configurationDisplayName("New note shortcut")
        .description("Shortcut to add new note.")
        .supportedFamilies(self.ⓕamilies)
    }
    init() {
        if UIDevice.current.userInterfaceIdiom == .phone {
            if #available(iOS 16.0, *) {
                self.ⓕamilies.append(contentsOf: [.accessoryInline, .accessoryCircular])
            }
        }
#if os(watchOS)
        self.ⓕamilies.append(contentsOf: [.accessoryCorner])
#endif
    }
}

private struct 🤖NewNoteShortcutProvider: TimelineProvider {
    func placeholder(in context: Context) -> 🕒NewNoteShortcutEntry {
        🕒NewNoteShortcutEntry()
    }
    func getSnapshot(in context: Context, completion: @escaping (🕒NewNoteShortcutEntry) -> ()) {
        completion(🕒NewNoteShortcutEntry())
    }
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        completion(Timeline(entries: [🕒NewNoteShortcutEntry()], policy: .never))
    }
}

private struct 🕒NewNoteShortcutEntry: TimelineEntry {
    let date: Date = .now
}

private struct 🄽ewNoteShortcutView: View {
    @Environment(\.widgetFamily) var widgetFamily
    var body: some View {
        Group {
            switch self.widgetFamily {
                case .accessoryInline:
                    Image(systemName: "plus.rectangle.on.rectangle")
                case .accessoryCircular:
                    if #available(iOS 16.0, *) {
                        ZStack {
                            AccessoryWidgetBackground()
                            Image(systemName: "plus")
                                .imageScale(.large)
                                .fontWeight(.medium)
                        }
                    }
                default:
                    Text("🐛")
            }
        }
        .widgetURL(🪧WidgetInfo.newNoteShortcut.url)
    }
}

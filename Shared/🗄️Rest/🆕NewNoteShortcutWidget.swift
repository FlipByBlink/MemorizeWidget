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
#if os(iOS)
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.ⓕamilies.append(contentsOf: [.accessoryInline, .accessoryCircular])
        }
#elseif os(watchOS)
        self.ⓕamilies.append(contentsOf: [.accessoryInline, .accessoryCircular, .accessoryCorner])
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
                    self.ⓒircleView()
#if os(watchOS)
                case .accessoryCorner:
                    self.ⓒircleView()
#endif
                default:
                    Text("🐛")
            }
        }
        .widgetURL(🪧WidgetInfo.newNoteShortcut.url)
    }
    private func ⓒircleView() -> some View {
        ZStack {
            AccessoryWidgetBackground()
            Image(systemName: "plus")
                .imageScale(.large)
                .fontWeight(.semibold)
        }
        .widgetAccentable()
    }
}

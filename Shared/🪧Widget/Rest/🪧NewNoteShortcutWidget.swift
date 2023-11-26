import SwiftUI
import WidgetKit

struct 🪧NewNoteShortcutWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "NewNoteShortcut", provider: 🪧NewNoteShortcutProvider()) { _ in
            🪧NewNoteShortcutView()
        }
        .configurationDisplayName("New note shortcut")
        .description("Shortcut to add new note.")
#if os(iOS)
        .supportedFamilies([.accessoryInline, .accessoryCircular])
#elseif os(watchOS)
        .supportedFamilies([.accessoryInline, .accessoryCircular, .accessoryCorner])
#endif
    }
}

private struct 🪧NewNoteShortcutProvider: TimelineProvider {
    func placeholder(in context: Context) -> 🪧NewNoteShortcutEntry {
        .init()
    }
    func getSnapshot(in context: Context, completion: @escaping (🪧NewNoteShortcutEntry) -> ()) {
        completion(.init())
    }
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        completion(Timeline(entries: [.init()], policy: .never))
    }
}

private struct 🪧NewNoteShortcutEntry: TimelineEntry {
    let date: Date = .now
}

private struct 🪧NewNoteShortcutView: View {
    @Environment(\.widgetFamily) var widgetFamily
    var body: some View {
        Group {
            switch self.widgetFamily {
                case .accessoryInline: Image(systemName: "plus.rectangle.on.rectangle")
                case .accessoryCircular: Self.circularView()
#if os(watchOS)
                case .accessoryCorner: Self.circularView()
#endif
                default: Text(verbatim: "BUG")
            }
        }
        .widgetURL(🪧Tag.newNoteShortcut.url)
        .modifier(🪧ContainerBackground())
    }
    private static func circularView() -> some View {
        ZStack {
            AccessoryWidgetBackground()
            Image(systemName: "plus")
                .font(.title.bold())
                .widgetAccentable()
        }
    }
}

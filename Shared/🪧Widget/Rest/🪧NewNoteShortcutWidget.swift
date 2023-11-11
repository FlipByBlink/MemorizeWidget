import SwiftUI
import WidgetKit

struct 🪧NewNoteShortcutWidget: Widget {
    private var families: [WidgetFamily] = []
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "NewNoteShortcut", provider: Self.Provider()) { _ in
            Self.EntryView()
        }
        .configurationDisplayName("New note shortcut")
        .description("Shortcut to add new note.")
        .supportedFamilies(self.families)
    }
    init() {
#if os(iOS)
        self.families.append(contentsOf: [.accessoryInline, .accessoryCircular])
#elseif os(watchOS)
        self.families.append(contentsOf: [.accessoryInline, .accessoryCircular, .accessoryCorner])
#endif
    }
}

private extension 🪧NewNoteShortcutWidget {
    private struct Provider: TimelineProvider {
        func placeholder(in context: Context) -> 🪧NewNoteShortcutWidget.SimpleEntry { .init() }
        func getSnapshot(in context: Context, completion: @escaping (🪧NewNoteShortcutWidget.SimpleEntry) -> ()) {
            completion(.init())
        }
        func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
            completion(Timeline(entries: [.init()], policy: .never))
        }
    }
    
    private struct SimpleEntry: TimelineEntry {
        let date: Date = .now
    }
    
    private struct EntryView: View {
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
                    .imageScale(.large)
                    .fontWeight(.semibold)
                    .widgetAccentable()
            }
        }
    }
}

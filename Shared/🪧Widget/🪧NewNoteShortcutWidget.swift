import SwiftUI
import WidgetKit

struct 🪧NewNoteShortcutWidget: Widget {
    private var ⓕamilies: [WidgetFamily] = []
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "NewNoteShortcut", provider: Self.Provider()) { _ in
            Self.EntryView()
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
                    case .accessoryInline:
                        Image(systemName: "plus.rectangle.on.rectangle")
                    case .accessoryCircular:
                        self.ⓒircleView()
#if os(watchOS)
                    case .accessoryCorner:
                        self.ⓒircleView()
#endif
                    default:
                        Text(verbatim: "🐛")
                }
            }
            .widgetURL(🪧WidgetInfo.newNoteShortcut.url)
            .modifier(🪧ContainerBackground())
        }
        private func ⓒircleView() -> some View {
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

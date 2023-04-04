import WidgetKit
import SwiftUI

@main
struct MWWidgetBundle: WidgetBundle {
    var body: some Widget {
        🖼MWWidget()
        📝NewNoteShortcutWidget()
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

struct 🕒Entry: TimelineEntry {
    let date: Date
    let ⓝote: 📗Note?
    init(_ date: Date, _ ⓝote: 📗Note?) {
        self.date = date
        self.ⓝote = ⓝote
    }
}

struct 🅆idgetEntryView: View {
    private var ⓘnfo: 🪧WidgetInfo
    @Environment(\.widgetFamily) var widgetFamily
    @AppStorage("ShowComment", store: .ⓐppGroup) var 🚩showComment: Bool = false
    private var ⓝotes: [📗Note] {
        self.ⓘnfo.notes
    }
    var body: some View {
        if let ⓝote = self.ⓝotes.first {
            switch self.widgetFamily {
                case .systemSmall:
                    self.ⓢystemSmallView()
                case .systemMedium:
                    ZStack {
                        Color.clear
                        VStack(spacing: 0) {
                            Spacer(minLength: 0)
                            Text(ⓝote.title)
                                .font(.title.bold())
                            if self.🚩showComment {
                                if ⓝote.comment != "" {
                                    Text(ⓝote.comment)
                                        .font(.title2)
                                        .foregroundStyle(.secondary)
                                }
                            }
                            Spacer(minLength: 0)
                        }
                        .padding()
                        .minimumScaleFactor(0.5)
                        .multilineTextAlignment(.center)
                    }
                    .widgetURL(self.ⓘnfo.url)
                case .accessoryRectangular:
                    if #available(iOS 16.0, *) {
                        ZStack {
                            VStack(spacing: 0) {
                                Text(ⓝote.title)
                                    .font(.headline)
                                if self.🚩showComment {
                                    if ⓝote.comment != "" {
                                        Text(ⓝote.comment)
                                            .font(.subheadline)
                                            .foregroundStyle(.secondary)
                                    }
                                }
                            }
                            .widgetAccentable()
                            .minimumScaleFactor(0.8)
                            .multilineTextAlignment(.center)
                        }
                        .widgetURL(self.ⓘnfo.url)
                    }
                case .accessoryInline:
                    if #available(iOS 16.0, *) {
                        Text(ⓝote.title)
                            .widgetURL(self.ⓘnfo.url)
                    }
                case .accessoryCircular:
                    if #available(iOS 16.0, *) {
                        ZStack {
                            AccessoryWidgetBackground()
                            Text(ⓝote.title)
                                .multilineTextAlignment(.center)
                                .font(.caption)
                                .fontWeight(.medium)
                                .padding(.horizontal, 2)
                        }
                        .widgetURL(self.ⓘnfo.url)
                    }
                default:
                    Text("🐛")
            }
        } else {
            Image(systemName: "books.vertical")
                .font(.title.weight(.medium))
                .foregroundStyle(.tertiary)
                .widgetURL(self.ⓘnfo.url)
        }
    }
    private func ⓢystemSmallView() -> some View {
        ZStack {
            Color.clear
            VStack(spacing: 2) {
                Spacer(minLength: 0)
                ForEach(self.ⓝotes) { ⓝote in
                    Text(ⓝote.title)
                        .font(.headline)
                    if self.🚩showComment {
                        if ⓝote.comment != "" {
                            Text(ⓝote.comment)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                Spacer(minLength: 0)
            }
            .padding()
            .minimumScaleFactor(0.5)
            .multilineTextAlignment(.center)
        }
        .widgetURL(self.ⓘnfo.url)
    }
    init(_ ⓔntry: 🤖TimelineProvider.Entry) {
        self.ⓘnfo = ⓔntry.info
    }
}

//MARK: - ➕NewNoteShortcut
struct 📝NewNoteShortcutWidget: Widget {
    private var ⓕamilies: [WidgetFamily] {
        guard #available(iOS 16.0, *) else { return [] }
        return [.accessoryInline, .accessoryCircular]
    }
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "NewNoteShortcut", provider: 🤖NewNoteShortcutProvider()) { _ in
            🄽ewNoteShortcutView()
        }
        .configurationDisplayName("New note shortcut")
        .description("Shortcut to add new note.")
        .supportedFamilies(self.ⓕamilies)
    }
}

struct 🤖NewNoteShortcutProvider: TimelineProvider {
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

struct 🕒NewNoteShortcutEntry: TimelineEntry {
    let date: Date = .now
}

struct 🄽ewNoteShortcutView: View {
    @Environment(\.widgetFamily) var widgetFamily
    var body: some View {
        switch self.widgetFamily {
            case .accessoryInline:
                if #available(iOS 16.0, *) {
                    Image(systemName: "plus.rectangle.on.rectangle")
                        .widgetURL(URL(string: "NewNoteShortcut")!)
                }
            case .accessoryCircular:
                if #available(iOS 16.0, *) {
                    ZStack {
                        AccessoryWidgetBackground()
                        Image(systemName: "plus")
                            .imageScale(.large)
                            .fontWeight(.medium)
                    }
                    .widgetURL(URL(string: "NewNoteShortcut")!)
                }
            default:
                Text("🐛")
        }
    }
}

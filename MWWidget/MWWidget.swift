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
    private var ⓕamilys: [WidgetFamily] = [.systemSmall, .systemMedium]
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "main", provider: 🤖NotesProvider()) { ⓔntry in
            🅆idgetEntryView(ⓔntry)
        }
        .configurationDisplayName("MemorizeWidget")
        .description("Show a note.")
        .supportedFamilies(self.ⓕamilys)
    }
    init() {
        if #available(iOS 16.0, *) {
            self.ⓕamilys.append(contentsOf: [.accessoryInline, .accessoryRectangular, .accessoryCircular])
        }
    }
}

struct 🖼MWWidgetSub: Widget {
    private var ⓕamilys: [WidgetFamily] = [.systemSmall, .systemMedium]
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "sub", provider: 🤖NotesProvider()) { ⓔntry in
            🅆idgetEntryView(ⓔntry)
        }
        .configurationDisplayName("Sub widget")
        .description("This is spare widget for the purpose of second widget and random-mode")
        .supportedFamilies(self.ⓕamilys)
    }
    init() {
        if #available(iOS 16.0, *) {
            self.ⓕamilys.append(contentsOf: [.accessoryRectangular, .accessoryCircular])
        }
    }
}

struct 🤖NotesProvider: TimelineProvider {
    func placeholder(in context: Context) -> 🕒Entry {
        🕒Entry(.now, 📗Note("title", "comment"))
    }
    func getSnapshot(in context: Context, completion: @escaping (🕒Entry) -> ()) {
        let ⓝotes: 📚Notes = .load() ?? []
        if ⓝotes.isEmpty {
            completion(🕒Entry(.now, nil))
        } else {
            if 💾AppGroupUD?.bool(forKey: "RandomMode") == true {
                completion(🕒Entry(.now, ⓝotes.randomElement()!))
            } else {
                completion(🕒Entry(.now, ⓝotes.first))
            }
        }
    }
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let ⓝotes: 📚Notes = .load() ?? []
        if ⓝotes.isEmpty {
            completion(Timeline(entries: [🕒Entry(.now, nil)],
                                policy: .after(Calendar.current.date(byAdding: .minute, value: 60, to: .now)!)))
        } else {
            if 💾AppGroupUD?.bool(forKey: "RandomMode") == true {
                var ⓔntries: [🕒Entry] = []
                for ⓒount in 0 ..< 12 {
                    let ⓞffset = ⓒount * 5
                    let ⓓate = Calendar.current.date(byAdding: .minute, value: ⓞffset, to: .now)!
                    let ⓝote = ⓝotes.randomElement()!
                    ⓔntries.append(🕒Entry(ⓓate, ⓝote))
                }
                completion(Timeline(entries: ⓔntries, policy: .atEnd))
            } else {
                completion(Timeline(entries: [🕒Entry(.now, ⓝotes.first)],
                                    policy: .after(Calendar.current.date(byAdding: .minute, value: 60, to: .now)!)))
            }
        }
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
    private var ⓝote: 📗Note?
    @Environment(\.widgetFamily) var ⓕamily: WidgetFamily
    @AppStorage("ShowComment", store: 💾AppGroupUD) var 🚩showComment: Bool = false
    var body: some View {
        if let ⓝote {
            switch self.ⓕamily {
                case .systemSmall:
                    ZStack {
                        Color.clear
                        VStack(spacing: 0) {
                            Spacer(minLength: 0)
                            Text(ⓝote.title)
                                .font(.headline)
                            if self.🚩showComment {
                                if ⓝote.comment != "" {
                                    Text(ⓝote.comment)
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }
                            }
                            Spacer(minLength: 0)
                        }
                        .padding()
                        .minimumScaleFactor(0.5)
                        .multilineTextAlignment(.center)
                    }
                    .widgetURL(URL(string: ⓝote.id.uuidString)!)
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
                    .widgetURL(URL(string: ⓝote.id.uuidString)!)
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
                        .widgetURL(URL(string: ⓝote.id.uuidString)!)
                    }
                case .accessoryInline:
                    if #available(iOS 16.0, *) {
                        Text(ⓝote.title)
                            .widgetURL(URL(string: ⓝote.id.uuidString)!)
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
                        .widgetURL(URL(string: ⓝote.id.uuidString)!)
                    }
                default:
                    Text("🐛")
            }
        } else {
            Image(systemName: "books.vertical")
                .font(.title.weight(.medium))
                .foregroundStyle(.tertiary)
        }
    }
    init(_ ⓔntry: 🤖NotesProvider.Entry) {
        self.ⓝote = ⓔntry.ⓝote
    }
}

//MARK: - ➕NewNoteShortcut
struct 📝NewNoteShortcutWidget: Widget {
    private var ⓕamilys: [WidgetFamily] {
        guard #available(iOS 16.0, *) else { return [] }
        return [.accessoryInline, .accessoryCircular]
    }
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "NewNoteShortcut", provider: 🤖NewNoteShortcutProvider()) { _ in
            🄽ewNoteShortcutView()
        }
        .configurationDisplayName("New note shortcut")
        .description("Shortcut to add new note.")
        .supportedFamilies(self.ⓕamilys)
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
    @Environment(\.widgetFamily) var ⓕamily: WidgetFamily
    var body: some View {
        switch self.ⓕamily {
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

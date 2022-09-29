
import WidgetKit
import SwiftUI

@main
struct MWWidgetBundle: WidgetBundle {
    var body: some Widget {
        🖼MWWidget()
        🖼MWWidgetSub()
        📝NewItemShortcutWidget()
    }
}

struct 🖼MWWidget: Widget {
    var ⓕamilys: [WidgetFamily] = [.systemSmall, .systemMedium]
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "main", provider: 🤖Provider()) { ⓔntry in
            🅆idgetEntryView(ⓔntry)
        }
        .configurationDisplayName("MemorizeWidget")
        .description("Show a note.")
        .supportedFamilies(ⓕamilys)
    }
    
    init() {
        if #available(iOS 16.0, *) {
            ⓕamilys.append(contentsOf: [.accessoryInline, .accessoryRectangular, .accessoryCircular])
        }
    }
}

struct 🖼MWWidgetSub: Widget {
    var ⓕamilys: [WidgetFamily] = [.systemSmall, .systemMedium]
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "sub", provider: 🤖Provider()) { ⓔntry in
            🅆idgetEntryView(ⓔntry)
        }
        .configurationDisplayName("Sub widget")
        .description("This is spare widget for the purpose of second widget and random-mode")
        .supportedFamilies(ⓕamilys)
    }
    
    init() {
        if #available(iOS 16.0, *) {
            ⓕamilys.append(contentsOf: [.accessoryRectangular, .accessoryCircular])
        }
    }
}

struct 📝NewItemShortcutWidget: Widget {
    var ⓕamilys: [WidgetFamily] {
        guard #available(iOS 16.0, *) else { return [] }
        return [.accessoryInline, .accessoryCircular]
    }
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "NewItemShortcut", provider: 🤖Provider()) { _ in
            🄽ewItemShortcutView()
        }
        .configurationDisplayName("Add new item widget")
        .description("Shortcut to add new item.")
        .supportedFamilies(ⓕamilys)
    }
}

struct 🤖Provider: TimelineProvider {
    func placeholder(in context: Context) -> 🕒Entry {
        🕒Entry(.now, 📓Note("title", "comment"))
    }
    
    func getSnapshot(in context: Context, completion: @escaping (🕒Entry) -> ()) {
        let 📱 = 📱AppModel()
        completion(🕒Entry(.now, 📱.📓GetWidgetNote()))
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let 📱 = 📱AppModel()
        var ⓔntries: [🕒Entry] = []
        for ⓒount in 0 ..< 12 {
            let ⓞffset = ⓒount * 5
            let ⓓate = Calendar.current.date(byAdding: .minute, value: ⓞffset, to: .now)!
            ⓔntries.append(🕒Entry(ⓓate, 📱.📓GetWidgetNote()))
        }
        completion(Timeline(entries: ⓔntries, policy: .atEnd))
    }
}


struct 🕒Entry: TimelineEntry {
    let date: Date
    let ⓝote: 📓Note
    
    init(_ date: Date, _ ⓝote: 📓Note) {
        self.date = date
        self.ⓝote = ⓝote
    }
}


struct 🅆idgetEntryView : View {
    var ⓔntry: 🤖Provider.Entry
    @Environment(\.widgetFamily) var ⓕamily: WidgetFamily
    let 📱 = 📱AppModel()
    
    @ViewBuilder
    var body: some View {
        switch ⓕamily {
            case .systemSmall:
                ZStack {
                    Color.clear
                    VStack(spacing: 0) {
                        Spacer(minLength: 0)
                        Text(ⓔntry.ⓝote.title)
                            .font(.headline)
                        if 📱.🚩ShowComment {
                            if ⓔntry.ⓝote.comment != "" {
                                Text(ⓔntry.ⓝote.comment)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        Spacer(minLength: 0)
                    }
                    .padding()
                    .minimumScaleFactor(0.5)
                }
                .widgetURL(URL(string: ⓔntry.ⓝote.id.uuidString)!)
            case .systemMedium:
                ZStack {
                    Color.clear
                    VStack(spacing: 0) {
                        Spacer(minLength: 0)
                        Text(ⓔntry.ⓝote.title)
                            .font(.title.bold())
                        if 📱.🚩ShowComment {
                            if ⓔntry.ⓝote.comment != "" {
                                Text(ⓔntry.ⓝote.comment)
                                    .font(.title2)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        Spacer(minLength: 0)
                    }
                    .padding()
                    .minimumScaleFactor(0.5)
                }
                .widgetURL(URL(string: ⓔntry.ⓝote.id.uuidString)!)
            case .accessoryRectangular:
                if #available(iOS 16.0, *) {
                    ZStack {
                        VStack(spacing: 0) {
                            Text(ⓔntry.ⓝote.title)
                                .font(.headline)
                            if 📱.🚩ShowComment {
                                if ⓔntry.ⓝote.comment != "" {
                                    Text(ⓔntry.ⓝote.comment)
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                        .widgetAccentable()
                        .minimumScaleFactor(0.5)
                    }
                    .widgetURL(URL(string: ⓔntry.ⓝote.id.uuidString)!)
                }
            case .accessoryInline:
                if #available(iOS 16.0, *) {
                    Text(ⓔntry.ⓝote.title)
                        .widgetURL(URL(string: ⓔntry.ⓝote.id.uuidString)!)
                }
            case .accessoryCircular:
                if #available(iOS 16.0, *) {
                    ZStack {
                        AccessoryWidgetBackground()
                        Text(ⓔntry.ⓝote.title)
                            .multilineTextAlignment(.center)
                            .font(.caption)
                            .fontWeight(.medium)
                            .padding(.horizontal, 2)
                    }
                    .widgetURL(URL(string: ⓔntry.ⓝote.id.uuidString)!)
                }
            default:
                Text("🐛")
        }
    }
    
    init(_ ⓔntry: 🤖Provider.Entry) {
        self.ⓔntry = ⓔntry
    }
}

struct 🄽ewItemShortcutView: View {
    @Environment(\.widgetFamily) var ⓕamily: WidgetFamily
    var body: some View {
        switch ⓕamily {
            case .accessoryInline:
                if #available(iOS 16.0, *) {
                    Image(systemName: "plus.rectangle.on.rectangle")
                        .widgetURL(URL(string: "NewItemShortcut")!)
                }
            case .accessoryCircular:
                if #available(iOS 16.0, *) {
                    ZStack {
                        AccessoryWidgetBackground()
                        Image(systemName: "plus.rectangle.on.rectangle")
                            .imageScale(.large)
                    }
                    .widgetURL(URL(string: "NewItemShortcut")!)
                }
            default:
                Text("🐛")
        }
    }
}

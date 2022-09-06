
import WidgetKit
import SwiftUI

@main
struct MWWidgetBundle: WidgetBundle {
    var body: some Widget {
        MWWidget()
        MWWidgetSub()
        MWLockScreenWidget()
        MWLockScreenWidgetSub()
    }
}

struct MWWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "homescreen.main", provider: 🤖Provider()) { ⓔntry in
            🅆idgetEntryView(ⓔntry)
        }
        .configurationDisplayName("MWWidget name")
        .description("placeholder")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct MWWidgetSub: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "homescreen.sub", provider: 🤖Provider()) { ⓔntry in
            🅆idgetEntryView(ⓔntry)
        }
        .configurationDisplayName("sub")
        .description("sub")
        .supportedFamilies([.systemSmall, .systemLarge])
    }
}

struct MWLockScreenWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "lockscreen.main", provider: 🤖Provider()) { ⓔntry in
            🅆idgetEntryView(ⓔntry)
        }
        .configurationDisplayName("Show title of a note.")
        .description("placeholder")
        .supportedFamilies([.accessoryInline, .accessoryRectangular, .accessoryCircular])
    }
}

struct MWLockScreenWidgetSub: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "lockscreen.sub", provider: 🤖Provider()) { ⓔntry in
            🅆idgetEntryView(ⓔntry)
        }
        .configurationDisplayName("lock screen sub")
        .description("placeholder sub")
        .supportedFamilies([.accessoryRectangular, .accessoryCircular])
    }
}


struct 🤖Provider: TimelineProvider {
    func placeholder(in context: Context) -> 🕒Entry {
        🕒Entry(.now, 📓Note(#function))
    }
    
    func getSnapshot(in context: Context, completion: @escaping (🕒Entry) -> ()) {
        completion(🕒Entry(.now, 📓Note(#function)))
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
    var ⓣextSize: (Font, Font) {
        switch ⓕamily {
            case .systemSmall: return (.headline, .subheadline)
            default: return (.title.bold(), .title2)
        }
    }
    
    @ViewBuilder
    var body: some View {
        ZStack {
            Color.clear
            
            VStack {
                Spacer()
                Text(ⓔntry.ⓝote.title)
                    .font(ⓣextSize.0)
                    .lineLimit(3)
                Text(ⓔntry.ⓝote.comment)
                    .font(ⓣextSize.1)
                    .foregroundStyle(.secondary)
                Spacer()
            }
            .padding()
            .minimumScaleFactor(0.1)
        }
        .widgetURL(URL(string: ⓔntry.ⓝote.id.uuidString)!)
        .overlay(alignment: .bottom) {
            Text(ⓔntry.date, style: .offset)
                .scaleEffect(0.8)
        }
    }
    
    init(_ ⓔntry: 🤖Provider.Entry) {
        self.ⓔntry = ⓔntry
    }
}

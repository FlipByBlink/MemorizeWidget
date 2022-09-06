
import WidgetKit
import SwiftUI

@main
struct MWWidgetBundle: WidgetBundle {
    var body: some Widget {
        MWWidget()
        MWWidget2()
    }
}

struct MWWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "net.aaaakkkkssssttttnnnn.MemorizeWidget.kind", provider: 🤖Provider()) { ⓔntry in
            🅆idgetEntryView(ⓔntry)
        }
        .configurationDisplayName("configurationDisplayName")
        .description("description")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct MWWidget2: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "net.aaaakkkkssssttttnnnn.MemorizeWidget.kind2", provider: 🤖Provider()) { ⓔntry in
            🅆idgetEntryView(ⓔntry)
        }
        .configurationDisplayName("configurationDisplayName2")
        .description("description2")
        .supportedFamilies([.systemSmall, .systemLarge])
    }
}


struct 🤖Provider: TimelineProvider {
    func placeholder(in context: Context) -> 🕒Entry {
        🕒Entry(.now, 🗒Item(#function))
    }
    
    func getSnapshot(in context: Context, completion: @escaping (🕒Entry) -> ()) {
        completion(🕒Entry(.now, 🗒Item(#function)))
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let 📱 = 📱AppModel()
        var ⓔntries: [🕒Entry] = []
        for ⓒount in 0 ..< 12 {
            let ⓞffset = ⓒount * 5
            let ⓓate = Calendar.current.date(byAdding: .minute, value: ⓞffset, to: .now)!
            ⓔntries.append(🕒Entry(ⓓate, 📱.🗒GetWidgetItem()))
        }
        completion(Timeline(entries: ⓔntries, policy: .atEnd))
    }
}


struct 🕒Entry: TimelineEntry {
    let date: Date
    let ⓘtem: 🗒Item
    
    init(_ date: Date, _ ⓘtem: 🗒Item) {
        self.date = date
        self.ⓘtem = ⓘtem
    }
}


struct 🅆idgetEntryView : View {
    var ⓔntry: 🤖Provider.Entry
    @Environment(\.widgetFamily) var 🄵amily: WidgetFamily
    var 🅃extSize: (Font, Font) {
        switch 🄵amily {
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
                Text(ⓔntry.ⓘtem.ⓣitle)
                    .font(🅃extSize.0)
                    .lineLimit(3)
                Text(ⓔntry.ⓘtem.ⓒomment)
                    .font(🅃extSize.1)
                    .foregroundStyle(.secondary)
                Spacer()
            }
            .padding()
            .minimumScaleFactor(0.1)
        }
        .widgetURL(URL(string: ⓔntry.ⓘtem.id.uuidString)!)
        .overlay(alignment: .bottom) {
            Text(ⓔntry.date, style: .offset)
                .scaleEffect(0.8)
        }
    }
    
    init(_ ⓔntry: 🤖Provider.Entry) {
        self.ⓔntry = ⓔntry
    }
}

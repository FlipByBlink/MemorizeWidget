import WidgetKit
import SwiftUI

@main
struct IOSWidgetBundle: WidgetBundle {
    var body: some Widget {
        Self.PrimaryWidget()
        🪧NewNoteShortcutWidget()
        Self.SubWidget()
    }
}

private extension IOSWidgetBundle {
    private struct PrimaryWidget: Widget {
        var body: some WidgetConfiguration {
            StaticConfiguration(kind: "main",
                                provider: 🪧Provider(kind: .primary)) { ⓔntry in
                🪧EntryView(ⓔntry)
            }
            .configurationDisplayName("MemorizeWidget")
            .description("Show a note.")
            .contentMarginsDisabled()
            .supportedFamilies([.systemSmall, .systemMedium, .systemLarge,
                                .accessoryInline, .accessoryRectangular, .accessoryCircular])
        }
    }
    private struct SubWidget: Widget {
        private var families: [WidgetFamily] = []
        var body: some WidgetConfiguration {
            StaticConfiguration(kind: "sub",
                                provider: 🪧Provider(kind: .sub)) { ⓔntry in
                🪧EntryView(ⓔntry)
            }
            .configurationDisplayName("Sub widget")
            .description("This is spare widget for the purpose of second widget and random-mode")
            .contentMarginsDisabled()
            .supportedFamilies(self.families)
        }
        init() {
            switch UIDevice.current.userInterfaceIdiom {
                case .phone: self.families.append(contentsOf: [.accessoryRectangular])
                case .pad: self.families.append(contentsOf: [.systemLarge])
                default: break
            }
        }
    }
}

import WidgetKit
import SwiftUI

struct 🪧SubWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "sub",
                            provider: 🪧Provider(kind: .sub)) {
            if $0.phase == .placeholder {
                🪧PlaceholderView()
            } else {
                🪧EntryView($0)
                    .modifier(Self.SnapshotTitle(condition: $0.phase == .snapshot))
            }
        }
        .configurationDisplayName("Sub widget")
        .description("This is spare widget for the purpose of second widget")
        .contentMarginsDisabled()
        .supportedFamilies(Self.families)
    }
}

private extension 🪧SubWidget {
    private static var families: [WidgetFamily] {
        var ⓥalue: [WidgetFamily] = [.accessoryCircular, .accessoryRectangular]
#if os(iOS)
        ⓥalue.append(contentsOf: [.systemSmall, .systemMedium])
        if UIDevice.current.userInterfaceIdiom == .pad {
            ⓥalue.append(.systemLarge)
        }
#elseif os(watchOS)
        ⓥalue.append(.accessoryCorner)
#endif
        return ⓥalue
    }
    private struct SnapshotTitle: ViewModifier {
        @Environment(\.widgetFamily) var widgetFamily
        var condition: Bool
        func body(content: Content) -> some View {
            if self.condition {
                content
                    .overlay {
                        ZStack(alignment: .bottom) {
                            Color.clear
                            switch self.widgetFamily {
#if os(iOS) || os(macOS)
                                case .systemSmall, .systemMedium, .systemLarge, .systemExtraLarge:
                                    Text("Sub")
                                        .font(.caption)
                                        .fontWeight(.medium)
                                        .padding(4)
#if os(iOS)
                                        .foregroundStyle(.secondary)
#endif
                                        .background(.regularMaterial)
                                        .clipShape(RoundedRectangle(cornerRadius: 6))
                                        .padding(8)
#endif
#if os(iOS) || os(watchOS)
                                case .accessoryCircular, .accessoryRectangular:
                                    Text("Sub")
                                        .underline()
                                        .foregroundStyle(.secondary)
                                        .font(.caption2.weight(.semibold))
                                        .lineLimit(1)
                                        .minimumScaleFactor(0.6)
#endif
                                default:
                                    EmptyView()
                            }
                        }
                    }
            } else {
                content
            }
        }
    }
}

import SwiftUI

struct 🪧PlaceholderView: View {
    @Environment(\.widgetFamily) var widgetFamily
    var body: some View {
        Group {
            switch self.widgetFamily {
#if os(iOS) || os(watchOS)
                case .accessoryInline, .accessoryCircular:
                    Text(verbatim: "Placeholder")
#endif
#if os(watchOS)
                case .accessoryCorner:
                    Image(systemName: "tag")
                        .widgetLabel("Placeholder" as String)
#endif
                default:
                    VStack(spacing: 2) {
                        Text(verbatim: "Placeholder")
                            .font(.system(size: self.titleFontSize))
                        Text(verbatim: "Placeholder")
                            .font(.system(size: self.commentFontSize))
                            .foregroundStyle(.secondary)
                    }
            }
        }
        .modifier(🪧ContainerBackground())
    }
}

private extension 🪧PlaceholderView {
    private var titleFontSize: CGFloat {
        switch self.widgetFamily {
            case .accessoryRectangular:
                20
            case .systemSmall:
                23
            case .systemMedium:
                30
            case .systemLarge:
                40
            case .systemExtraLarge:
                50
            default:
                23
        }
    }
    private var commentFontSize: CGFloat {
        switch self.widgetFamily {
            case .accessoryRectangular:
                14
            case .systemSmall:
                16
            case .systemMedium:
                20
            case .systemLarge:
                23
            case .systemExtraLarge:
                24
            default:
                14
        }
    }
}

import WidgetKit

extension WidgetFamily {
    var ⓜultiNotesCount: Int {
        switch self {
            case .systemSmall: 3
            case .systemMedium: 3
            case .systemLarge: 6
            case .accessoryCircular: 2
            case .accessoryRectangular: 3
            case .accessoryInline: 1
#if os(watchOS)
            case .accessoryCorner: 1
#endif
            default: 1
        }
    }
}

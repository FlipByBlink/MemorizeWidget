import SwiftUI

struct 🪧SystemWidgetView: View {
    private var ⓘnfo: 🪧WidgetInfo
    @Environment(\.widgetFamily) var widgetFamily
    @Environment(\.widgetRenderingMode) var widgetRenderingMode
    @AppStorage("ShowComment", store: .ⓐppGroup) var 🚩showComment: Bool = false
    var body: some View {
        ZStack {
            Color.clear
            VStack(spacing: 0) {
                Spacer(minLength: 0)
                VStack(spacing: self.ⓝotesSpace) {
                    ForEach(self.ⓝotes) { ⓝote in
                        VStack(spacing: self.ⓝotes.count == 1 ? 6 : 2) {
                            Text(ⓝote.title)
                                .font(self.ⓣitleFont.bold())
                            if self.🚩showComment, !ⓝote.comment.isEmpty {
                                Text(ⓝote.comment)
                                    .font(self.ⓒommentFontStyle)
                                    .fontWeight(self.ⓒommentFontWeight)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .lineLimit(self.ⓛineLimit)
                        .multilineTextAlignment(.center)
                    }
                }
                Spacer(minLength: 0)
            }
        }
        .padding(self.ⓟadding)
        .dynamicTypeSize(...DynamicTypeSize.xLarge)
    }
    init(_ info: 🪧WidgetInfo) {
        self.ⓘnfo = info
    }
}

private extension 🪧SystemWidgetView {
    private var ⓝotes: [📗Note] { self.ⓘnfo.targetedNotes }
    private var ⓣitleFont: Font {
        switch self.widgetFamily {
            case .systemSmall:
                return self.ⓝotes.count == 1 ? .title3 : .headline
            case .systemMedium:
                return self.ⓝotes.count == 1 ? .title : .headline
            case .systemLarge:
                switch self.ⓝotes.count {
                    case 1: return .largeTitle
                    case 2, 3, 4, 5: return .title
                    case 6: return self.🚩showComment ? .headline : .title
                    default: assertionFailure(); return .title
                }
            default:
                assertionFailure(); return .largeTitle
        }
    }
    private var ⓒommentFontStyle: Font {
        switch self.widgetFamily {
            case .systemSmall, .systemMedium:
                return self.ⓝotes.count == 1 ? .body : .caption
            case .systemLarge:
                return self.ⓝotes.count == 1 ? .title2 : .subheadline
            default:
                assertionFailure(); return .body
        }
    }
    private var ⓒommentFontWeight: Font.Weight {
        switch self.widgetRenderingMode {
            case .fullColor: return .light
            case .vibrant, .accented: return .medium
            default: assertionFailure(); return .regular
        }
    }
    private var ⓛineLimit: Int {
        switch self.widgetFamily {
            case .systemSmall, .systemMedium:
                return self.ⓝotes.count == 1 ? 3 : 1
            case .systemLarge:
                return self.ⓝotes.count < 4 ? 3 : 1
            default:
                assertionFailure(); return 1
        }
    }
    private var ⓝotesSpace: CGFloat {
        switch self.widgetFamily {
            case .systemSmall, .systemMedium:
                if self.ⓝotes.count == 3, self.🚩showComment {
                    return 7
                } else {
                    return 12
                }
            case .systemLarge:
                if self.ⓝotes.count == 6, self.🚩showComment {
                    return 8
                } else {
                    return 16
                }
            default:
                assertionFailure(); return 8
        }
    }
    private var ⓟadding: CGFloat {
        switch self.widgetFamily {
            case .systemSmall: return 12
            case .systemMedium: return 16
            case .systemLarge: return 18
            default: assertionFailure(); return 12
        }
    }
}

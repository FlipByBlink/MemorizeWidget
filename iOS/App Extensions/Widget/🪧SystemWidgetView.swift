import SwiftUI

struct 🪧SystemWidgetView: View {
    private var ⓘnfo: 🪧WidgetInfo
    @Environment(\.widgetFamily) var widgetFamily
    @Environment(\.widgetRenderingMode) var widgetRenderingMode
    @AppStorage("ShowComment", store: .ⓐppGroup) var 🚩showComment: Bool = false
    var body: some View {
        VStack(spacing: 0) {
            Spacer(minLength: 0)
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
                .minimumScaleFactor(0.9)
                Spacer(minLength: 0)
            }
        }
        .frame(maxWidth: .infinity)
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
                    case 2, 3, 4, 5: return self.🚩showComment ? .title3 : .title
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
                switch self.ⓝotes.count {
                    case 1: return .title3
                    case 2, 3, 4, 5: return .subheadline
                    case 6: return .caption
                    default: assertionFailure(); return .title
                }
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
    private var ⓟadding: EdgeInsets {
        switch self.widgetFamily {
            case .systemSmall: return .init(top: 8, leading: 16, bottom: 8, trailing: 16)
            case .systemMedium: return .init(top: 8, leading: 24, bottom: 8, trailing: 24)
            case .systemLarge: return .init(top: 12, leading: 32, bottom: 12, trailing: 32)
            default: assertionFailure(); return .init()
        }
    }
}

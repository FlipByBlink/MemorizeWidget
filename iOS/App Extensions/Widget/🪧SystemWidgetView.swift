import SwiftUI

struct 🪧SystemWidgetView: View {
    private var info: 🪧WidgetInfo
    @Environment(\.widgetFamily) var widgetFamily
    @Environment(\.widgetRenderingMode) var widgetRenderingMode
    @AppStorage("ShowComment", store: .ⓐppGroup) var showComment: Bool = false
    var body: some View {
        VStack(spacing: 0) {
            Spacer(minLength: 0)
            ForEach(self.notes) { ⓝote in
                VStack(spacing: self.notes.count == 1 ? 6 : 2) {
                    Text(ⓝote.title)
                        .font(self.titleFont.bold())
                    if self.showComment, !ⓝote.comment.isEmpty {
                        Text(ⓝote.comment)
                            .font(self.commentFont)
                            .fontWeight(self.commentFontWeight)
                            .foregroundStyle(.secondary)
                    }
                }
                .lineLimit(self.lineLimitNumber)
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.9)
                Spacer(minLength: 0)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(self.edgeInsets)
        .dynamicTypeSize(...DynamicTypeSize.xLarge)
    }
    init(_ info: 🪧WidgetInfo) {
        self.info = info
    }
}

private extension 🪧SystemWidgetView {
    private var notes: [📗Note] { self.info.targetedNotes }
    private var titleFont: Font {
        switch self.widgetFamily {
            case .systemSmall:
                return self.notes.count == 1 ? .title3 : .headline
            case .systemMedium:
                return self.notes.count == 1 ? .title : .headline
            case .systemLarge:
                switch self.notes.count {
                    case 1: return .largeTitle
                    case 2, 3, 4, 5: return self.showComment ? .title3 : .title
                    case 6: return self.showComment ? .headline : .title
                    default: assertionFailure(); return .title
                }
            default:
                assertionFailure(); return .largeTitle
        }
    }
    private var commentFont: Font {
        switch self.widgetFamily {
            case .systemSmall, .systemMedium:
                return self.notes.count == 1 ? .body : .caption
            case .systemLarge:
                switch self.notes.count {
                    case 1: return .title3
                    case 2, 3, 4, 5: return .subheadline
                    case 6: return .caption
                    default: assertionFailure(); return .title
                }
            default:
                assertionFailure(); return .body
        }
    }
    private var commentFontWeight: Font.Weight {
        switch self.widgetRenderingMode {
            case .fullColor: return .light
            case .vibrant, .accented: return .medium
            default: assertionFailure(); return .regular
        }
    }
    private var lineLimitNumber: Int {
        switch self.widgetFamily {
            case .systemSmall, .systemMedium:
                return self.notes.count == 1 ? 3 : 1
            case .systemLarge:
                return self.notes.count < 4 ? 3 : 1
            default:
                assertionFailure(); return 1
        }
    }
    private var edgeInsets: EdgeInsets {
        switch self.widgetFamily {
            case .systemSmall: return .init(top: 8, leading: 16, bottom: 8, trailing: 16)
            case .systemMedium: return .init(top: 8, leading: 24, bottom: 8, trailing: 24)
            case .systemLarge: return .init(top: 12, leading: 32, bottom: 12, trailing: 32)
            default: assertionFailure(); return .init()
        }
    }
}

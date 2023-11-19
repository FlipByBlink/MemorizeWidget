import SwiftUI

struct 🪧SystemWidgetView: View {
    private var notes: 📚Notes
    @Environment(\.widgetFamily) var widgetFamily
    @Environment(\.widgetRenderingMode) var widgetRenderingMode
    var body: some View {
        VStack(spacing: 0) {
            Spacer(minLength: 0)
            ForEach(self.notes) { ⓝote in
                VStack(spacing: self.notes.count == 1 ? 6 : 2) {
                    Text(ⓝote.title)
                        .font(self.titleFont.bold())
                    if 🎛️Option.showCommentMode, !ⓝote.comment.isEmpty {
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
    init(_ ⓣag: 🪧Tag) {
        self.notes = ⓣag.loadTargetedNotes()
    }
}

private extension 🪧SystemWidgetView {
    private var titleFont: Font {
        if 🎛️Option.customizeFontSize {
            return .system(size: CGFloat(🎛️Option.FontSize.SystemFamily.title))
        } else {
            switch self.widgetFamily {
                case .systemSmall:
                    return self.notes.count == 1 ? .title3 : .headline
                case .systemMedium:
                    return self.notes.count == 1 ? .largeTitle : .headline
                case .systemLarge:
                    switch self.notes.count {
                        case 1:
                            return .system(size: 60)
                        case 2, 3, 4, 5:
                            return 🎛️Option.showCommentMode ? .title3 : .title
                        default:
                            assertionFailure()
                            return .title
                    }
                case .systemExtraLarge:
                    switch self.notes.count {
                        case 1:
                            return .system(size: 120)
                        case 2, 3, 4, 5:
                            return 🎛️Option.showCommentMode ? .title3 : .title
                        default:
                            assertionFailure()
                            return .title
                    }
                default:
                    assertionFailure()
                    return .largeTitle
            }
        }
    }
    private var commentFont: Font {
        if 🎛️Option.customizeFontSize {
            return .system(size: CGFloat(🎛️Option.FontSize.SystemFamily.comment))
        } else {
            switch self.widgetFamily {
                case .systemSmall, .systemMedium:
                    return self.notes.count == 1 ? .body : .caption
                case .systemLarge:
                    switch self.notes.count {
                        case 1: return .title3
                        case 2, 3, 4, 5: return .subheadline
                        default: assertionFailure(); return .title
                    }
                case .systemExtraLarge:
                    switch self.notes.count {
                        case 1: return .title
                        case 2, 3, 4, 5: return .body
                        default: assertionFailure(); return .title
                    }
                default:
                    assertionFailure(); return .body
            }
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
                return self.notes.count == 1 ? 4 : 1
            case .systemLarge, .systemExtraLarge:
                return self.notes.count < 4 ? 5 : 1
            default:
                assertionFailure()
                return 1
        }
    }
    private var edgeInsets: EdgeInsets {
        switch self.widgetFamily {
            case .systemSmall: return .init(top: 8, leading: 16, bottom: 8, trailing: 16)
            case .systemMedium: return .init(top: 8, leading: 24, bottom: 8, trailing: 24)
            case .systemLarge: return .init(top: 12, leading: 32, bottom: 12, trailing: 32)
            case .systemExtraLarge: return .init(top: 12, leading: 42, bottom: 12, trailing: 42)
            default: assertionFailure(); return .init()
        }
    }
}

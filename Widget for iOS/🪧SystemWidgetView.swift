import SwiftUI

struct 🪧SystemWidgetView: View {
    private var ⓘnfo: 🪧WidgetInfo
    @Environment(\.widgetFamily) var widgetFamily
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
                            if self.🚩showComment {
                                if !ⓝote.comment.isEmpty {
                                    Text(ⓝote.comment)
                                        .font(self.ⓒommentFont.weight(.light))
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                        .lineLimit(self.ⓛineLimit)
                        .minimumScaleFactor(0.8)
                        .multilineTextAlignment(.center)
                    }
                }
                Spacer(minLength: 0)
            }
        }
        .padding(self.widgetFamily == .systemLarge ? 18 : 14)
        .dynamicTypeSize(...DynamicTypeSize.xxLarge)
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
                return self.ⓝotes.count == 1 ? .title : .title3
            case .systemLarge:
                if self.ⓝotes.count == 1 {
                    return .largeTitle
                } else {
                    return self.🚩showComment ? .title3 : .title
                }
            default:
                assertionFailure(); return .largeTitle
        }
    }
    private var ⓒommentFont: Font {
        switch self.widgetFamily {
            case .systemSmall, .systemMedium:
                return self.ⓝotes.count == 1 ? .body : .caption
            case .systemLarge:
                return self.ⓝotes.count == 1 ? .title2 : .subheadline
            default:
                assertionFailure(); return .body
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
                return self.🚩showComment ? 6 : 12
            case .systemLarge:
                if self.ⓝotes.count == 6 {
                    return self.🚩showComment ? 8 : 12
                } else {
                    return self.🚩showComment ? 10 : 16
                }
            default:
                assertionFailure(); return 8
        }
    }
}

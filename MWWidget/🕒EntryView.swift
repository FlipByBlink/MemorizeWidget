import SwiftUI
import WidgetKit

struct 🅆idgetEntryView: View {
    private var ⓘnfo: 🪧WidgetInfo
    @Environment(\.widgetFamily) var widgetFamily
    var body: some View {
        if !self.ⓘnfo.notes.isEmpty {
            Group {
                switch self.widgetFamily {
                    case .systemSmall, .systemMedium, .systemLarge:
                        🄷omeScreenWidgetView(self.ⓘnfo)
                    case .accessoryCorner, .accessoryInline, .accessoryCircular, .accessoryRectangular:
                        🄰ccessaryWidgetView(self.ⓘnfo)
                    default:
                        Text("🐛")
                }
            }
            .widgetURL(self.ⓘnfo.url)
        } else {
            self.ⓝoNoteView()
        }
    }
    private func ⓝoNoteView() -> some View {
        Image(systemName: "books.vertical")
            .font(.title.weight(.medium))
            .foregroundStyle(.tertiary)
    }
    init(_ ⓔntry: 🕒WidgetEntry) {
        self.ⓘnfo = ⓔntry.info
    }
}

private struct 🄷omeScreenWidgetView: View {
    private var ⓘnfo: 🪧WidgetInfo
    @Environment(\.widgetFamily) var widgetFamily
    @AppStorage("ShowComment", store: .ⓐppGroup) var 🚩showComment: Bool = false
    private var ⓝotes: [📗Note] { self.ⓘnfo.notes }
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
                    return self.🚩showComment ? .title2 : .title
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
                return self.ⓝotes.count == 1 ? .title2 : .body
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
                if self.ⓝotes.count < 6 {
                    return self.🚩showComment ? 12 : 16
                } else {
                    return self.🚩showComment ? 10 : 12
                }
            default:
                assertionFailure(); return 8
        }
    }
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
            .padding(self.widgetFamily == .systemLarge ? 20 : 16)
        }
    }
    init(_ info: 🪧WidgetInfo) {
        self.ⓘnfo = info
    }
}

private struct 🄰ccessaryWidgetView: View {
    private var ⓘnfo: 🪧WidgetInfo
    @Environment(\.widgetFamily) var widgetFamily
    @AppStorage("ShowComment", store: .ⓐppGroup) var 🚩showComment: Bool = false
    private var ⓝotes: [📗Note] { self.ⓘnfo.notes }
    var body: some View {
        switch self.widgetFamily {
            case .accessoryCorner, .accessoryInline:
                self.ⓞneLineView()
            case .accessoryCircular:
                self.ⓒircleView()
            case .accessoryRectangular:
                self.ⓡectangularView()
            default:
                Text("🐛")
        }
    }
    private func ⓞneLineView() -> some View {
        Group {
            if #available(iOS 16.0, *) {
                Text(self.ⓝotes.first?.title ?? "🐛")
            }
        }
    }
    private func ⓒircleView() -> some View {
        Group {
            if #available(iOS 16.0, *) {
                ZStack {
                    AccessoryWidgetBackground()
                    VStack(spacing: 2) {
                        ForEach(self.ⓝotes) { ⓝote in
                            if self.ⓝotes.firstIndex(of: ⓝote) == 1 { Divider() }
                            Text(ⓝote.title)
                                .multilineTextAlignment(.center)
                                .font(.caption)
                                .fontWeight(.medium)
                                .lineSpacing(0)
                                .minimumScaleFactor(0.8)
                                .padding(.horizontal, self.ⓝotes.count == 1 ? 1 : 3)
                        }
                    }
                    .padding(.vertical, 1)
                }
            }
        }
    }
    private func ⓡectangularView() -> some View {
        Group {
            if #available(iOS 16.0, *) {
                ZStack {
                    VStack(spacing: 0) {
                        ForEach(self.ⓝotes) { ⓝote in
                            Text(ⓝote.title)
                                .font(.headline)
                                .lineLimit(self.ⓝotes.count > 1 ? 1 : 3)
                            if case .singleNote(_) = self.ⓘnfo {
                                if self.🚩showComment, !ⓝote.comment.isEmpty {
                                    Text(ⓝote.comment)
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                    }
                    .widgetAccentable()
                    .minimumScaleFactor(0.8)
                    .multilineTextAlignment(.center)
                }
            }
        }
    }
    init(_ info: 🪧WidgetInfo) {
        self.ⓘnfo = info
    }
}

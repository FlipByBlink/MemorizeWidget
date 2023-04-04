import SwiftUI
import WidgetKit

struct 🅆idgetEntryView: View {
    private var ⓘnfo: 🪧WidgetInfo
    @Environment(\.widgetFamily) var widgetFamily
    @AppStorage("ShowComment", store: .ⓐppGroup) var 🚩showComment: Bool = false
    private var ⓝotes: [📗Note] { self.ⓘnfo.notes }
    var body: some View {
        if !self.ⓝotes.isEmpty {
            Group {
                switch self.widgetFamily {
                    case .systemSmall: self.ⓢystemSmallView()
                    case .systemMedium: self.ⓢystemMediumView()
                    case .systemLarge: self.ⓢystemLargeView()
                    case .systemExtraLarge: self.ⓢystemExtraLargeView()
                    case .accessoryCorner: self.ⓐccessoryCornerView()
                    case .accessoryCircular: self.ⓐccessoryCircleView()
                    case .accessoryRectangular: self.ⓐccessoryRectangularView()
                    case .accessoryInline: self.ⓐccessoryInlineView()
                    default: Text("🐛")
                }
            }
            .widgetURL(self.ⓘnfo.url)
        } else {
            self.ⓝoNoteView()
        }
    }
    private func ⓢystemSmallView() -> some View {
        ZStack {
            Color.clear
            VStack(spacing: 2) {
                Spacer(minLength: 0)
                ForEach(self.ⓝotes) { ⓝote in
                    Text(ⓝote.title)
                        .font(.headline)
                    if self.🚩showComment {
                        if ⓝote.comment != "" {
                            Text(ⓝote.comment)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                Spacer(minLength: 0)
            }
            .padding()
            .minimumScaleFactor(0.5)
            .multilineTextAlignment(.center)
        }
    }
    private func ⓢystemMediumView() -> some View {
        ZStack {
            Color.clear
            VStack(spacing: 0) {
                Spacer(minLength: 0)
                ForEach(self.ⓝotes) { ⓝote in
                    Text(ⓝote.title)
                        .font(.title.bold())
                    if self.🚩showComment {
                        if ⓝote.comment != "" {
                            Text(ⓝote.comment)
                                .font(.title2)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                Spacer(minLength: 0)
            }
            .padding()
            .minimumScaleFactor(0.5)
            .multilineTextAlignment(.center)
        }
    }
    private func ⓢystemLargeView() -> some View {
        EmptyView()
    }
    private func ⓢystemExtraLargeView() -> some View {
        EmptyView()
    }
    private func ⓐccessoryCornerView() -> some View {
        EmptyView()
    }
    private func ⓐccessoryCircleView() -> some View {
        Group {
            if #available(iOS 16.0, *) {
                ZStack {
                    AccessoryWidgetBackground()
                    if let ⓝote = self.ⓝotes.first {
                        Text(ⓝote.title)
                            .multilineTextAlignment(.center)
                            .font(.caption)
                            .fontWeight(.medium)
                            .padding(.horizontal, 2)
                    } else {
                        Text("🐛")
                    }
                }
            }
        }
    }
    private func ⓐccessoryRectangularView() -> some View {
        Group {
            if #available(iOS 16.0, *) {
                ZStack {
                    VStack(spacing: 0) {
                        ForEach(self.ⓝotes) { ⓝote in
                            Text(ⓝote.title)
                                .font(.headline)
                            if self.🚩showComment {
                                if ⓝote.comment != "" {
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
    private func ⓐccessoryInlineView() -> some View {
        Group {
            if #available(iOS 16.0, *) {
                if let ⓝote = self.ⓝotes.first {
                    Text(ⓝote.title)
                }
            }
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

import SwiftUI
import WidgetKit

struct 🪧EntryView: View {
    private var ⓘnfo: 🪧WidgetInfo
    @Environment(\.widgetFamily) var widgetFamily
    @Environment(\.widgetRenderingMode) var widgetRenderingMode
    @AppStorage("ShowComment", store: .ⓐppGroup) var 🚩showComment: Bool = false
    private var ⓝotes: [📗Note] { self.ⓘnfo.targetedNotes }
    var body: some View {
        Group {
            if !self.ⓝotes.isEmpty {
                switch self.widgetFamily {
                    case .accessoryInline: self.ⓘnlineView()
                    case .accessoryCircular: self.ⓒircleView()
                    case .accessoryRectangular: self.ⓡectangularView()
                    case .accessoryCorner: self.ⓒornerView()
                    default: Text("🐛")
                }
            } else {
                Image(systemName: "book.closed")
                    .foregroundStyle(.tertiary)
            }
        }
        .widgetURL(self.ⓘnfo.url)
        .modifier(🎨ContainerBackground())
    }
    private func ⓘnlineView() -> some View {
        Text(self.ⓝotes.first?.title ?? "No note")
    }
    private func ⓒircleView() -> some View {
        ZStack {
            AccessoryWidgetBackground()
            VStack(spacing: 2) {
                ForEach(self.ⓝotes) { ⓝote in
                    if self.ⓝotes.firstIndex(of: ⓝote) == 1 { Divider() }
                    Text(ⓝote.title)
                        .multilineTextAlignment(.center)
                        .font(.caption2.weight(.medium))
                        .lineSpacing(0)
                        .minimumScaleFactor(0.8)
                        .padding(.horizontal, self.ⓝotes.count == 1 ? 1 : 3)
                        .widgetAccentable()
                }
            }
            .padding(.vertical, 1)
        }
    }
    private func ⓡectangularView() -> some View {
        VStack(spacing: 0) {
            ForEach(self.ⓝotes) { ⓝote in
                Text(ⓝote.title)
                    .font(.headline)
                    .lineLimit(self.ⓝotes.count > 1 ? 1 : 3)
                if case .singleNote(_) = self.ⓘnfo {
                    if self.🚩showComment, !ⓝote.comment.isEmpty {
                        Text(ⓝote.comment)
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                            .opacity(self.widgetRenderingMode == .accented ? 0.6 : 1)
                    }
                }
            }
        }
        .widgetAccentable()
        .minimumScaleFactor(0.8)
        .multilineTextAlignment(.center)
    }
    private func ⓒornerView() -> some View {
        Image(systemName: "tag")
            .font(.title.weight(.medium))
            .widgetAccentable()
            .widgetLabel(self.ⓝotes.first?.title ?? "No note")
    }
    init(_ ⓔntry: 🪧WidgetEntry) {
        self.ⓘnfo = ⓔntry.info
    }
}

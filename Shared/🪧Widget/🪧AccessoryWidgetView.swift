import SwiftUI
import WidgetKit

struct 🪧AccessoryWidgetView: View {
    private var ⓘnfo: 🪧WidgetInfo
    @Environment(\.widgetFamily) var widgetFamily
    @AppStorage("ShowComment", store: .ⓐppGroup) var 🚩showComment: Bool = false
    var body: some View {
        switch self.widgetFamily {
            case .accessoryInline: self.ⓘnlineView()
            case .accessoryCircular: self.ⓒircleView()
            case .accessoryRectangular: self.ⓡectangularView()
            #if os(watchOS)
            case .accessoryCorner: self.ⓒornerView()
            #endif
            default: Text(verbatim: "🐛")
        }
    }
    init(_ info: 🪧WidgetInfo) {
        self.ⓘnfo = info
    }
}

private extension 🪧AccessoryWidgetView {
    private var ⓝotes: [📗Note] { self.ⓘnfo.targetedNotes }
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
                        .font(.caption.weight(.medium))
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
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            //.opacity(self.widgetRenderingMode == .accented ? 0.6 : 1) //TODO: watchOS版では実装されてた。要再検討
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
}

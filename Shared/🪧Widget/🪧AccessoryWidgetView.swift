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
                        .font(self.ⓝotes.count == 1 ? .body : .caption)
                        .fontWeight(.semibold)
                        .lineSpacing(0)
                        .minimumScaleFactor(0.8)
                        .padding(.horizontal, 3)
                        .widgetAccentable()
                }
            }
            .padding(.vertical, 1)
            .clipShape(Circle())
        }
    }
    private func ⓡectangularView() -> some View {
        VStack(spacing: 0) {
            ForEach(self.ⓝotes) { ⓝote in
                Text(ⓝote.title)
                    .lineLimit(self.ⓝotes.count > 1 ? 1 : 3)
                    .font(.system(size: self.ⓝotes.count > 1 ? 21 : 24,
                                  weight: .semibold))
                if case .singleNote(_) = self.ⓘnfo {
                    if self.🚩showComment, !ⓝote.comment.isEmpty {
                        Text(ⓝote.comment)
                            .fontWeight(.medium)
                            .foregroundStyle(.secondary)
                            .padding(.top, 4)
                            .lineLimit(1)
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

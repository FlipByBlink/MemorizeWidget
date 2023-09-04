import SwiftUI
import WidgetKit

struct 🪧AccessoryWidgetView: View {
    private var ⓘnfo: 🪧WidgetInfo
    @Environment(\.widgetFamily) var widgetFamily
    @AppStorage("ShowComment", store: .ⓐppGroup) var 🚩showComment: Bool = false
    private var ⓝotes: [📗Note] { self.ⓘnfo.targetedNotes }
    var body: some View {
        switch self.widgetFamily {
            case .accessoryInline: self.ⓘnlineView()
            case .accessoryCircular: self.ⓒircleView()
            case .accessoryRectangular: self.ⓡectangularView()
            default: Text(verbatim: "🐛")
        }
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
                        .font(.caption.weight(.medium))
                        .lineSpacing(0)
                        .minimumScaleFactor(0.8)
                        .padding(.horizontal, self.ⓝotes.count == 1 ? 1 : 3)
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
                    }
                }
            }
        }
        .minimumScaleFactor(0.8)
        .multilineTextAlignment(.center)
    }
    init(_ info: 🪧WidgetInfo) {
        self.ⓘnfo = info
    }
}

import SwiftUI
import WidgetKit

struct 🪧AccessoryWidgetView: View {
    private var info: 🪧WidgetInfo
    @Environment(\.widgetFamily) var widgetFamily
    @AppStorage("ShowComment", store: .ⓐppGroup) var showComment: Bool = false
    var body: some View {
        switch self.widgetFamily {
            case .accessoryInline: self.inlineView()
            case .accessoryCircular: self.circularView()
            case .accessoryRectangular: self.rectangularView()
            #if os(watchOS)
            case .accessoryCorner: self.cornerView()
            #endif
            default: Text(verbatim: "BUG")
        }
    }
    init(_ info: 🪧WidgetInfo) {
        self.info = info
    }
}

private extension 🪧AccessoryWidgetView {
    private var notes: [📗Note] { self.info.targetedNotes }
    private func inlineView() -> some View {
        Text(self.notes.first?.title ?? "No note")
    }
    private func circularView() -> some View {
        ZStack {
            AccessoryWidgetBackground()
            ZStack {
                Color.clear
                VStack(spacing: 2) {
                    ForEach(self.notes) { ⓝote in
                        if self.notes.firstIndex(of: ⓝote) == 1 { Divider() }
                        Text(ⓝote.title)
                            .multilineTextAlignment(.center)
                            .font(self.notes.count == 1 ? .body : .caption)
                            .fontWeight(.semibold)
                            .lineSpacing(0)
                            .minimumScaleFactor(0.8)
                            .padding(.horizontal, 3)
                            .widgetAccentable()
                    }
                }
                .padding(.vertical, 1)
                .lineLimit(self.notes.count == 2 ? 2 : nil)
            }
            .clipShape(Circle())
        }
    }
    private func rectangularView() -> some View {
        VStack {
            ForEach(self.notes) { ⓝote in
                Text(ⓝote.title)
                    .lineLimit(self.notes.count > 1 ? 1 : 3)
                    .font(.system(size: self.notes.count > 1 ? 17 : 24,
                                  weight: .semibold))
                if case .singleNote(_) = self.info {
                    if self.showComment, !ⓝote.comment.isEmpty {
                        Text(ⓝote.comment)
                            .fontWeight(.medium)
                            .foregroundStyle(.secondary)
                            .lineLimit(1)
                    }
                }
            }
        }
        .widgetAccentable()
        .minimumScaleFactor(0.8)
        .multilineTextAlignment(.center)
    }
    private func cornerView() -> some View {
        Image(systemName: "tag")
            .font(.title.weight(.medium))
            .widgetAccentable()
            .widgetLabel(self.notes.first?.title ?? "No note")
    }
}

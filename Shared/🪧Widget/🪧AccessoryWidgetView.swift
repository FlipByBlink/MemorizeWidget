import SwiftUI
import WidgetKit

struct 🪧AccessoryWidgetView: View {
    private var notes: [📗Note]
    @Environment(\.widgetFamily) var widgetFamily
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
    init(_ ⓣag: 🪧Tag) {
        self.notes = ⓣag.loadTargetedNotes()
    }
}

private extension 🪧AccessoryWidgetView {
    private func inlineView() -> some View {
        Text(self.notes.first?.title ?? "No note")
    }
    private func circularView() -> some View {
        ZStack {
            AccessoryWidgetBackground()
            ZStack {
                Color.clear
                if let ⓝote = self.notes.first {
                    Text(ⓝote.title)
                        .font(self.titleFontSize)
                        .multilineTextAlignment(🎛️Option.multilineTextAlignment.value)
                        .fontWeight(.semibold)
                        .lineSpacing(0)
                        .minimumScaleFactor(0.8)
                        .padding(.horizontal, 3)
                        .widgetAccentable()
                        .lineSpacing(0)
                }
            }
            .clipShape(Circle())
        }
    }
    private func rectangularView() -> some View {
        VStack(spacing: 0) {
            ForEach(self.notes) { ⓝote in
                Text(ⓝote.title)
                    .lineLimit(self.notes.count > 1 ? 1 : 3)
                    .font(self.titleFontSize)
                    .fontWeight(.semibold)
                if (self.notes.count == 1)
                    && 🎛️Option.showCommentMode
                    && !ⓝote.comment.isEmpty {
                    Text(ⓝote.comment)
                        .font(self.commentFontSize)
                        .fontWeight(.medium)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
            }
        }
        .widgetAccentable()
        .minimumScaleFactor(0.8)
        .multilineTextAlignment(🎛️Option.multilineTextAlignment.value)
    }
    private func cornerView() -> some View {
        Image(systemName: "tag")
            .font(.title.weight(.medium))
            .widgetAccentable()
            .widgetLabel(self.notes.first?.title ?? "No note")
    }
    private var titleFontSize: Font {
        if 🎛️Option.customizeFontSize {
            .system(size: CGFloat(🎛️Option.FontSize.AccessoryFamily.title))
        } else {
            switch self.widgetFamily {
                case .accessoryCircular:
                        .body
                case .accessoryRectangular:
                    if self.notes.count == 1 {
                        .system(size: 28)
                    } else {
                        .system(size: 17)
                    }
                default:
                        .body
            }
        }
    }
    private var commentFontSize: Font {
        if 🎛️Option.customizeFontSize {
            .system(size: CGFloat(🎛️Option.FontSize.AccessoryFamily.comment))
        } else {
            .body
        }
    }
}

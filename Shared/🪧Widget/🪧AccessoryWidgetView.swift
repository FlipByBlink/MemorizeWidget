import SwiftUI
import WidgetKit

struct 🪧AccessoryWidgetView: View {
    var notes: [📗Note]
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
                        .multilineTextAlignment(🎛️Option.multilineTextAlignment.value())
                        .fontWeight(.semibold)
                        .lineSpacing(0)
                        .minimumScaleFactor(0.9)
                        .padding(.horizontal, 3)
                        .widgetAccentable()
                }
            }
            .clipShape(Circle())
        }
    }
    private func rectangularView() -> some View {
        VStack(alignment: 🎛️Option.multilineTextAlignment.value(), spacing: 0) {
            ForEach(self.notes) { ⓝote in
                Text(ⓝote.title)
                    .font(self.titleFontSize)
                    .fontWeight(.semibold)
                if (self.notes.count == 1)
                    && 🎛️Option.showCommentMode
                    && !ⓝote.comment.isEmpty {
                    Text(ⓝote.comment)
                        .font(self.commentFontSize)
                        .fontWeight(.medium)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .lineLimit(self.lineLimit)
        .widgetAccentable()
        .minimumScaleFactor(0.9)
        .multilineTextAlignment(🎛️Option.multilineTextAlignment.value())
    }
#if os(watchOS)
    private func cornerView() -> some View {
        Image(systemName: "tag")
            .font(.title.weight(.medium))
            .widgetAccentable()
            .widgetLabel(self.notes.first?.title ?? "No note")
    }
#endif
    private var lineLimit: Int? {
        if 🎛️Option.multiNotesMode {
            1
        } else {
            if 🎛️Option.customizeFontSize {
                nil
            } else {
                if 🎛️Option.showCommentMode {
                    1
                } else {
                    2
                }
            }
        }
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
                        if 🎛️Option.showCommentMode {
                            .system(size: 22)
                        } else {
                            .system(size: 25)
                        }
                    } else {
                        .system(size: 16)
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

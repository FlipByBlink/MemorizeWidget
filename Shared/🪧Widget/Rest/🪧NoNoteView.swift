import SwiftUI

struct 🪧NoNoteView: View {
    @Environment(\.widgetFamily) var widgetFamily
    @Environment(\.showsWidgetContainerBackground) var showsWidgetContainerBackground
    var body: some View {
        Group {
            switch self.widgetFamily {
                case .systemSmall, .systemMedium:
                    Label("No note", systemImage: "book.closed")
                        .font(.title)
                        .foregroundStyle(
                            self.showsWidgetContainerBackground ? .tertiary : .secondary
                        )
                case .systemLarge, .systemExtraLarge:
                    Label("No note", systemImage: "book.closed")
                        .font(.largeTitle)
                        .foregroundStyle(.tertiary)
                case .accessoryRectangular:
                    Label("No note", systemImage: "book.closed")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                case .accessoryCircular:
                    Text("No note")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.secondary)
                case .accessoryInline, .accessoryCorner:
                    Label("No note", systemImage: "book.closed")
                default:
                    Image(systemName: "book.closed")
            }
        }
    }
}

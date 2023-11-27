import SwiftUI

struct 🪧NoNoteView: View {
    @Environment(\.widgetFamily) var widgetFamily
    @Environment(\.showsWidgetContainerBackground) var showsWidgetContainerBackground
    var body: some View {
        switch self.widgetFamily {
            case .systemSmall:
                Label("No note", systemImage: "book.closed")
                    .font(.title2)
                    .foregroundStyle(self.showsWidgetContainerBackground ? .tertiary : .secondary)
                    .padding(8)
            case .systemMedium:
                Label("No note", systemImage: "book.closed")
                    .font(.title)
                    .foregroundStyle(.tertiary)
                    .padding()
            case .systemLarge, .systemExtraLarge:
                Label("No note", systemImage: "book.closed")
                    .font(.largeTitle)
                    .foregroundStyle(.tertiary)
                    .padding()
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

import SwiftUI

struct 🪧NoNoteView: View {
    @Environment(\.widgetFamily) var widgetFamily
    var body: some View {
        Group {
            switch self.widgetFamily {
                case .accessoryRectangular:
                    Label("No note", systemImage: "book.closed")
                        .font(.headline)
                case .accessoryCircular:
                    Text("No note")
                        .font(.subheadline)
                case .accessoryInline, .accessoryCorner:
                    Label("No note", systemImage: "book.closed")
                default:
                    Image(systemName: "book.closed")
            }
        }
        .foregroundStyle(.tertiary)
    }
}

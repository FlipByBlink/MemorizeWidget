import SwiftUI

struct 🪧NoNoteView: View {
    @Environment(\.widgetFamily) var widgetFamily
    var body: some View {
        switch self.widgetFamily {
            case .systemSmall, .systemMedium, .systemLarge, .systemExtraLarge:
                Label("No note", systemImage: "book.closed")
                    .font(.largeTitle)
                    .foregroundStyle(.tertiary)
            default:
                Image(systemName: "book.closed")
                    .font(.title3)
                    .foregroundStyle(.tertiary)
        }
    }
}

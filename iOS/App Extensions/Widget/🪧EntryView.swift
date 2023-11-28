import SwiftUI

struct 🪧EntryView: View {
    private var entry: 🪧NotesEntry
    @Environment(\.widgetFamily) var widgetFamily
    var body: some View {
        Group {
            if self.entry.pickedNotes.isEmpty {
                🪧NoNoteView()
            } else {
                switch self.widgetFamily {
                    case .systemSmall, .systemMedium, .systemLarge, .systemExtraLarge:
                        🪧SystemWidgetView(notes: self.entry.pickedNotes)
                    case .accessoryInline, .accessoryCircular, .accessoryRectangular:
                        🪧AccessoryWidgetView(notes: self.entry.pickedNotes)
                    default:
                        Text(verbatim: "BUG")
                }
            }
        }
        .widgetURL(self.entry.tag.url)
        .modifier(🪧ContainerBackground())
    }
    init(_ entry: 🪧NotesEntry) {
        self.entry = entry
    }
}

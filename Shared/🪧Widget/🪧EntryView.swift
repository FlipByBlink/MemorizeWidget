import SwiftUI

struct 🪧EntryView: View {
    private var entry: 🪧NotesEntry
    @Environment(\.widgetFamily) var widgetFamily
    var body: some View {
        Group {
            if self.entry.pickedNotes.isEmpty {
                🪧NoNoteView()
            } else {
#if os(iOS)
                switch self.widgetFamily {
                    case .systemSmall, .systemMedium, .systemLarge, .systemExtraLarge:
                        🪧SystemWidgetView(notes: self.entry.pickedNotes)
                    case .accessoryInline, .accessoryCircular, .accessoryRectangular:
                        🪧AccessoryWidgetView(notes: self.entry.pickedNotes)
                    default:
                        Text(verbatim: "BUG")
                }
#elseif os(watchOS)
                🪧AccessoryWidgetView(notes: self.entry.pickedNotes)
#elseif os(macOS)
                🪧SystemWidgetView(notes: self.entry.pickedNotes)
#endif
            }
        }
        .widgetURL(self.entry.tag.url)
        .modifier(🪧ContainerBackground())
    }
    init(_ entry: 🪧NotesEntry) {
        self.entry = entry
    }
}

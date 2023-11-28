import SwiftUI

struct 🪧EntryView: View {
    private var entry: 🪧Entry
    @Environment(\.widgetFamily) var widgetFamily
    var body: some View {
        Group {
            switch self.entry.phase {
                case .placeholder:
                    🪧PlaceholderView()
                case .snapshot, .inTimeline:
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
        }
        .widgetURL(self.widgetURL)
        .modifier(🪧ContainerBackground())
    }
    init(_ entry: 🪧Entry) {
        self.entry = entry
    }
}

private extension 🪧EntryView {
    private var widgetURL: URL {
        switch self.entry.phase {
            case .placeholder:
                🪧Tag.placeholder.url
            case .snapshot, .inTimeline:
                🪧Tag.notes(self.entry.pickedNotes.map(\.id)).url
        }
    }
}

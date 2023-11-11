import SwiftUI

struct 🪧EntryView: View {
    private var entry: 🪧Entry
    var body: some View {
        Group {
            if self.entry.tag.targetedNotes.isEmpty {
                🪧PlaceholderView()
            } else {
                🪧AccessoryWidgetView(self.entry.tag)
            }
        }
        .widgetURL(self.entry.tag.url)
        .modifier(🪧ContainerBackground())
    }
    init(_ entry: 🪧Entry) {
        self.entry = entry
    }
}

import SwiftUI

struct 🪧EntryView: View {
    private var entry: 🪧NotesEntry
    var body: some View {
        Group {
            if self.entry.pickedNotes.isEmpty {
                🪧NoNoteView()
            } else {
                🪧AccessoryWidgetView(notes: self.entry.pickedNotes)
            }
        }
        .widgetURL(self.entry.tag.url)
        .modifier(🪧ContainerBackground())
    }
    init(_ entry: 🪧NotesEntry) {
        self.entry = entry
    }
}

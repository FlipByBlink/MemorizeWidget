import SwiftUI

struct 🪧EntryView: View {
    private var tag: 🪧Tag
    var body: some View {
        Group {
            if self.tag.loadTargetedNotes().isEmpty {
                🪧NoNoteView()
            } else {
                🪧SystemWidgetView(self.tag)
            }
        }
        .widgetURL(self.tag.url)
        .modifier(🪧ContainerBackground())
    }
    init(_ ⓔntry: 🪧Entry) {
        self.tag = ⓔntry.tag
    }
}

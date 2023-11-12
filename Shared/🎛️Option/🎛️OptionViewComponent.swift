import SwiftUI
import WidgetKit

enum 🎛️OptionViewComponent {
    struct MultiNotesToggle: View {
        @AppStorage("multiNotes", store: .ⓐppGroup) var value: Bool = false
        var body: some View {
            Toggle(isOn: self.$value) {
                Label("Show multi notes on widget", systemImage: "doc.on.doc")
            }
            .onChange(of: self.value) { _ in
                WidgetCenter.shared.reloadAllTimelines()
            }
        }
    }
    struct ShowCommentToggle: View {
        @AppStorage("ShowComment", store: .ⓐppGroup) var value: Bool = false
        var body: some View {
            Toggle(isOn: self.$value) {
                Label("Show comment on widget", systemImage: "captions.bubble")
            }
            .onChange(of: self.value) { _ in
                WidgetCenter.shared.reloadAllTimelines()
            }
        }
    }
}

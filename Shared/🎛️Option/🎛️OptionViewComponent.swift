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
    struct WidgetTitleSizeForSingleModePicker: View {
        @AppStorage("widgetTitleSizeForSingleMode", store: .ⓐppGroup)
        var value: 🎛️WidgetTitleSizeForSingleMode = .default
        var body: some View {
            Picker(selection: self.$value) {
                ForEach(🎛️WidgetTitleSizeForSingleMode.allCases) {
                    Text($0.rawValue)
                }
            } label: {
                Label("Title font size on widget (single note mode only)",
                      systemImage: "textformat.size")
            }
            .onChange(of: self.value) { _ in
                WidgetCenter.shared.reloadAllTimelines()
            }
        }
    }
}

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
    enum FontSize {
        struct CustomizeFontSizeToggle: View {
            @AppStorage("customizeFontSize", store: .ⓐppGroup) var value: Bool = false
            var body: some View {
                Toggle(isOn: self.$value) {
                    Label("Customize font size", systemImage: "textformat.size")
                }
                .onChange(of: self.value) { _ in
                    WidgetCenter.shared.reloadAllTimelines()
                }
            }
        }
        struct TitleForSystemFamilyPreview: View {
            @AppStorage("titleSizeForSystemFamily", store: .ⓐppGroup)
            var value: Int = 22
            var body: some View {
                HStack {
                    Spacer()
                    VStack(spacing: 12) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 36, style: .continuous)
                                .fill(.white)
                                .shadow(color: .gray, radius: 4)
                            Text(verbatim: "(TITLE)")
                                .font(.system(size: CGFloat(self.value), weight: .bold))
                                .foregroundStyle(.purple)
                        }
                        .frame(width: 280, height: 280)
                        Text("Preview")
                            .foregroundStyle(.secondary)
                            .tracking(0.5)
                            .font(.subheadline.italic().weight(.light))
                    }
                    .padding(.top, 24)
                    Spacer()
                }
                .listRowBackground(Color.clear)
            }
        }
        struct TitleForSystemFamilyPicker: View {
            @AppStorage("titleSizeForSystemFamily", store: .ⓐppGroup)
            var value: Int = 22
            var body: some View {
                Picker(selection: self.$value) {
                    ForEach(9 ..< 250, id: \.self) {
                        Text($0.description)
                    }
                } label: {
                    Label("Title font size",
                          systemImage: "textformat.size")
                }
                .onChange(of: self.value) { _ in
                    WidgetCenter.shared.reloadAllTimelines()
                }
            }
        }
        struct TitleForAccessoryFamilyPicker: View {
            @AppStorage("titleSizeForAccessoryFamily", store: .ⓐppGroup)
            var value: Int = 14
            var body: some View {
                Picker(selection: self.$value) {
                    ForEach(7 ..< 40, id: \.self) {
                        Text($0.description)
                    }
                } label: {
                    Label("Title font size", 
                          systemImage: "textformat.size")
                }
                .onChange(of: self.value) { _ in
                    WidgetCenter.shared.reloadAllTimelines()
                }
            }
        }
    }
}

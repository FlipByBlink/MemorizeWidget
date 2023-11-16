import SwiftUI
import WidgetKit

enum 🎛️ViewComponent {
    struct MultiNotesToggle: View {
        @AppStorage(🎛️Key.multiNotesMode, store: .ⓐppGroup) var value: Bool = false
        var body: some View {
            Toggle(isOn: self.$value) {
                Label("Show multi notes on widget", systemImage: "doc.on.doc")
            }
            .onChange(of: self.value) { _ in WidgetCenter.shared.reloadAllTimelines() }
        }
    }
    struct ShowCommentToggle: View {
        @AppStorage(🎛️Key.showCommentMode, store: .ⓐppGroup) var value: Bool = false
        var body: some View {
            Toggle(isOn: self.$value) {
                Label("Show comment on widget", systemImage: "captions.bubble")
            }
            .onChange(of: self.value) { _ in WidgetCenter.shared.reloadAllTimelines() }
        }
    }
    enum FontSize {
        struct CustomizeToggle: View {
            @AppStorage(🎛️Key.FontSize.customize, store: .ⓐppGroup) var value: Bool = false
            var body: some View {
                Toggle(isOn: self.$value) {
                    Label("Customize font size", systemImage: "textformat.size")
                }
                .onChange(of: self.value) { _ in WidgetCenter.shared.reloadAllTimelines() }
                .task { 🎛️Default.setValues() }
            }
        }
        struct SystemFamilyPreview: View {
            @AppStorage(🎛️Key.FontSize.SystemFamily.title, store: .ⓐppGroup)
            var titleValue: Int = 🎛️Default.FontSize.SystemFamily.title
            
            @AppStorage(🎛️Key.FontSize.SystemFamily.comment, store: .ⓐppGroup)
            var commentValue: Int = 🎛️Default.FontSize.SystemFamily.comment
            
            var body: some View {
                HStack {
                    Spacer()
                    VStack(spacing: 12) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 36, style: .continuous)
                                .fill(.white)
                                .shadow(color: .gray, radius: 4)
                            VStack(spacing: 5) {
                                Text("(TITLE)")
                                    .font(.system(size: CGFloat(self.titleValue), weight: .bold))
                                    .foregroundStyle(.purple)
                                Text("(Comment)")
                                    .font(.system(size: CGFloat(self.commentValue), weight: .light))
                                    .foregroundStyle(.green)
                            }
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
                .animation(.default, value: self.titleValue)
                .animation(.default, value: self.commentValue)
            }
        }
        struct TitleForSystemFamilyPicker: View {
            @AppStorage(🎛️Key.FontSize.SystemFamily.title, store: .ⓐppGroup)
            var value: Int = 🎛️Default.FontSize.SystemFamily.title
            
            var body: some View {
                Picker(selection: self.$value) {
                    ForEach(9 ..< 270, id: \.self) { Text(verbatim: "\($0)") }
                } label: {
                    Label("Title size", systemImage: "textformat.size")
                }
                .onChange(of: self.value) { _ in WidgetCenter.shared.reloadAllTimelines() }
            }
        }
        struct CommentForSystemFamilyPicker: View {
            @AppStorage(🎛️Key.FontSize.SystemFamily.comment, store: .ⓐppGroup)
            var value: Int = 🎛️Default.FontSize.SystemFamily.comment
            
            var body: some View {
                Picker(selection: self.$value) {
                    ForEach(6 ..< 60, id: \.self) { Text(verbatim: "\($0)") }
                } label: {
                    Label("Comment size", systemImage: "captions.bubble")
                }
                .onChange(of: self.value) { _ in WidgetCenter.shared.reloadAllTimelines() }
            }
        }
        struct TitleForAccessoryFamilyPicker: View {
            @AppStorage(🎛️Key.FontSize.AccessoryFamily.title, store: .ⓐppGroup)
            var value: Int = 🎛️Default.FontSize.AccessoryFamily.title
            
            var body: some View {
                Picker(selection: self.$value) {
                    ForEach(7 ..< 80, id: \.self) { Text(verbatim: "\($0)") }
                } label: {
                    Label("Title size",  systemImage: "textformat.size")
                }
                .onChange(of: self.value) { _ in WidgetCenter.shared.reloadAllTimelines() }
            }
        }
        struct CommentForAccessoryFamilyPicker: View {
            @AppStorage(🎛️Key.FontSize.AccessoryFamily.comment, store: .ⓐppGroup)
            var value: Int = 🎛️Default.FontSize.AccessoryFamily.comment
            
            var body: some View {
                Picker(selection: self.$value) {
                    ForEach(7 ..< 22, id: \.self) { Text(verbatim: "\($0)") }
                } label: {
                    Label("Comment size",  systemImage: "captions.bubble")
                }
                .onChange(of: self.value) { _ in WidgetCenter.shared.reloadAllTimelines() }
            }
        }
    }
}

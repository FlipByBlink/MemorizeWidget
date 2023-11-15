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
            }
        }
        struct SystemFamilyPreview: View {
            @AppStorage(🎛️Key.FontSize.SystemFamily.title, store: .ⓐppGroup) var titleValue: Int = 22
            @AppStorage(🎛️Key.FontSize.SystemFamily.comment, store: .ⓐppGroup) var commentValue: Int = 12
            var body: some View {
                HStack {
                    Spacer()
                    VStack(spacing: 12) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 36, style: .continuous)
                                .fill(.white)
                                .shadow(color: .gray, radius: 4)
                            VStack(spacing: 5) {
                                Text(verbatim: "(TITLE)")
                                    .font(.system(size: CGFloat(self.titleValue), weight: .bold))
                                    .foregroundStyle(.purple)
                                Text(verbatim: "(Comment)")
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
            @AppStorage(🎛️Key.FontSize.SystemFamily.title, store: .ⓐppGroup) var value: Int = 22
            var body: some View {
                Picker(selection: self.$value) {
                    ForEach(9 ..< 250, id: \.self) { Text("\($0)") }
                } label: {
                    Label("Title font size", systemImage: "textformat.size")
                }
                .onChange(of: self.value) { _ in WidgetCenter.shared.reloadAllTimelines() }
            }
        }
        struct CommentForSystemFamilyPicker: View {
            @AppStorage(🎛️Key.FontSize.SystemFamily.comment, store: .ⓐppGroup) var value: Int = 12
            var body: some View {
                Picker(selection: self.$value) {
                    ForEach(6 ..< 60, id: \.self) { Text("\($0)") }
                } label: {
                    Label("Comment font size", systemImage: "captions.bubble")
                }
                .onChange(of: self.value) { _ in WidgetCenter.shared.reloadAllTimelines() }
            }
        }
        struct AccessoryFamilyPreview: View {
            @AppStorage(🎛️Key.FontSize.AccessoryFamily.title, store: .ⓐppGroup) var titleValue: Int = 14
            @AppStorage(🎛️Key.FontSize.AccessoryFamily.comment, store: .ⓐppGroup) var commentValue: Int = 9
            var body: some View {
                HStack {
                    Spacer()
                    VStack(spacing: 12) {
                        HStack(spacing: 16) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    .fill(.white)
                                    .shadow(color: .gray, radius: 3)
                                VStack(spacing: 2) {
                                    Text(verbatim: "(TITLE)")
                                        .font(.system(size: CGFloat(self.titleValue), weight: .bold))
                                        .foregroundStyle(.purple)
                                    Text(verbatim: "(Comment)")
                                        .font(.system(size: CGFloat(self.commentValue), weight: .light))
                                        .foregroundStyle(.green)
                                }
                            }
                            .frame(width: 200, height: 80) //TODO: 実際のサイズに近付ける
                            ZStack {
                                Circle()
                                    .fill(.white)
                                    .shadow(color: .gray, radius: 3)
                                Text(verbatim: "(TITLE)")
                                    .font(.system(size: CGFloat(self.titleValue), weight: .bold))
                                    .foregroundStyle(.purple)
                            }
                            .frame(width: 70, height: 70) //TODO: 実際のサイズに近付ける
                        }
                        Text("Preview")
                            .foregroundStyle(.secondary)
                            .tracking(0.5)
                            .font(.subheadline.italic().weight(.light))
                    }
                    .padding(.top, 12)
                    Spacer()
                }
                .listRowBackground(Color.clear)
                .animation(.default, value: self.titleValue)
                .animation(.default, value: self.commentValue)
            }
        }
        struct TitleForAccessoryFamilyPicker: View {
            @AppStorage(🎛️Key.FontSize.AccessoryFamily.title, store: .ⓐppGroup) var value: Int = 18
            var body: some View {
                Picker(selection: self.$value) {
                    ForEach(7 ..< 40, id: \.self) { Text("\($0)") }
                } label: {
                    Label("Title font size",  systemImage: "textformat.size")
                }
                .onChange(of: self.value) { _ in WidgetCenter.shared.reloadAllTimelines() }
            }
        }
        struct CommentForAccessoryFamilyPicker: View {
            @AppStorage(🎛️Key.FontSize.AccessoryFamily.comment, store: .ⓐppGroup) var value: Int = 10
            var body: some View {
                Picker(selection: self.$value) {
                    ForEach(7 ..< 40, id: \.self) { Text("\($0)") }
                } label: {
                    Label("Comment font size",  systemImage: "captions.bubble")
                }
                .onChange(of: self.value) { _ in WidgetCenter.shared.reloadAllTimelines() }
            }
        }
    }
}

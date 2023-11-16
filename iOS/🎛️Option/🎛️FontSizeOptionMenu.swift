import SwiftUI

struct 🎛️FontSizeOptionMenu: View {
    var body: some View {
        List {
            🎛️ViewComponent.FontSize.CustomizeToggle()
            Section { Self.SystemWidgetMenuLink() }
            Section { Self.AccessoryWidgetMenuLink() }
        }
        .navigationTitle("Font size on widget")
    }
}

private extension 🎛️FontSizeOptionMenu {
    private struct SystemWidgetMenuLink: View {
        @Environment(\.horizontalSizeClass) var horizontalSizeClass
        var body: some View {
            NavigationLink {
                List {
                    🎛️ViewComponent.FontSize.SystemFamilyPreview()
                    Section {
                        🎛️ViewComponent.FontSize.TitleForSystemFamilyPicker()
                        🎛️ViewComponent.FontSize.CommentForSystemFamilyPicker()
                    } footer: {
                        Text("環境やテキストによって実際に表示されるサイズは変化します")
                    }
                    Section { Self.about() }
                }
                .navigationTitle("System widget")
            } label: {
                LabeledContent {
                    Image(.systemFamilyExample)
                        .resizable()
                        .scaledToFit()
                        .frame(width: self.horizontalSizeClass == .compact ? 120 : 180)
                        .shadow(radius: 2, y: 1)
                        .padding(8)
                } label: {
                    Label(self.horizontalSizeClass == .compact ? "System\nwidget" : "System widget",
                          systemImage: "slider.horizontal.3")
                }
                .modifier(🎛️FontSizeOptionMenu.LinkOpacity())
            }
        }
        private static func about() -> some View {
            Text("""
                __Target__
                Home screen
                Notification center
                StandBy
                Desktop
                Lock screen(iPad)
                """)
            .multilineTextAlignment(.center)
            .font(.caption)
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity)
            .listRowBackground(Color.clear)
        }
    }
    private struct AccessoryWidgetMenuLink: View {
        @Environment(\.horizontalSizeClass) var horizontalSizeClass
        var body: some View {
            NavigationLink {
                List {
                    Self.Preview()
                    Section {
                        🎛️ViewComponent.FontSize.TitleForAccessoryFamilyPicker()
                        🎛️ViewComponent.FontSize.CommentForAccessoryFamilyPicker()
                    } footer: {
                        Text("環境やテキストによって実際に表示されるサイズは変化します")
                    }
                    Section { Self.about() }
                }
                .navigationTitle("Accessory widget")
            } label: {
                LabeledContent {
                    Image(.accessoryFamilyExample)
                        .resizable()
                        .scaledToFit()
                        .frame(width: self.horizontalSizeClass == .compact ? 120 : 180)
                        .shadow(radius: 2, y: 1)
                        .padding(8)
                } label: {
                    Label(self.horizontalSizeClass == .compact ? "Accessory\nwidget" : "Accessory widget",
                          systemImage: "slider.horizontal.3")
                }
                .modifier(🎛️FontSizeOptionMenu.LinkOpacity())
            }
        }
        private struct Preview: View {
            @AppStorage(🎛️Key.FontSize.AccessoryFamily.title, store: .ⓐppGroup)
            var titleValue: Int = 🎛️Default.FontSize.AccessoryFamily.title
            
            @AppStorage(🎛️Key.FontSize.AccessoryFamily.comment, store: .ⓐppGroup)
            var commentValue: Int = 🎛️Default.FontSize.AccessoryFamily.comment
            
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
        private static func about() -> some View {
            Text("""
                __Target__
                Lock screen
                Apple Watch complication
                """)
            .multilineTextAlignment(.center)
            .font(.caption)
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity)
            .listRowBackground(Color.clear)
        }
    }
    private struct LinkOpacity: ViewModifier {
        @AppStorage(🎛️Key.FontSize.customize, store: .ⓐppGroup) var customizeFontSize: Bool = false
        func body(content: Content) -> some View {
            content
                .opacity(self.customizeFontSize ? 1 : 0.5)
                .animation(.default, value: self.customizeFontSize)
        }
    }
}

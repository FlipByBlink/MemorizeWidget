import SwiftUI

struct 🎛️FontSizeOptionMenu: View {
    @AppStorage("customizeFontSize", store: .ⓐppGroup) var customizeFontSize: Bool = false
    var body: some View {
        List {
            🎛️ViewComponent.FontSize.CustomizeToggle()
            Group {
                Section { Self.SystemWidgetMenuLink() }
                Section { Self.AccessoryWidgetMenuLink() }
            }
            .disabled(!self.customizeFontSize)
            .animation(.default, value: self.customizeFontSize)
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
                    }
                    Section { Self.about() }
                }
                .navigationTitle("System widget")
            } label: {
                LabeledContent {
                    Image(.homeScreenExample)
                        .resizable()
                        .scaledToFit()
                        .frame(width: self.horizontalSizeClass == .compact ? 120 : 180)
                        .shadow(radius: 2, y: 1)
                        .padding(8)
                } label: {
                    Label(self.horizontalSizeClass == .compact ? "System\nwidget" : "System widget",
                          systemImage: "slider.horizontal.3")
                }
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
                    //AccessoryWidgetPreview()
                    🎛️ViewComponent.FontSize.TitleForAccessoryFamilyPicker()
                    Section { Self.about() }
                }
                .navigationTitle("Accessory widget")
            } label: {
                LabeledContent {
                    Image(.lockScreenExample)
                        .resizable()
                        .scaledToFit()
                        .frame(width: self.horizontalSizeClass == .compact ? 120 : 180)
                        .shadow(radius: 2, y: 1)
                        .padding(8)
                } label: {
                    Label(self.horizontalSizeClass == .compact ? "Accessory\nwidget" : "Accessory widget",
                          systemImage: "slider.horizontal.3")
                }
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
}

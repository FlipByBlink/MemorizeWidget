import SwiftUI
import WidgetKit

struct 🎛️RandomModeToggle: View {
    @EnvironmentObject var model: 📱AppModel
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var body: some View {
        Toggle(isOn: self.$model.randomMode) {
#if os(iOS)
            if UIDevice.current.userInterfaceIdiom == .pad {
                self.labelForIPad()
            } else {
                Self.label()
            }
#else
            Self.label()
#endif
        }
        .onChange(of: self.model.randomMode) { _ in
            WidgetCenter.shared.reloadAllTimelines()
        }
#if os(iOS)
        .modifier(📚DisableInEditMode())
#endif
    }
    struct Caption: View {
        var body: some View {
            Text("Change the note per 5 minutes.")
        }
    }
}

private extension 🎛️RandomModeToggle {
    private static func label() -> some View {
        Label("Random mode", systemImage: "shuffle")
    }
    private func labelForIPad() -> some View {
#if os(iOS)
        Group {
            switch self.horizontalSizeClass {
                case .compact:
                    Self.label()
                default:
                    LabeledContent {
                        Text("Per 5 minutes")
                            .font(.caption.weight(.light))
                            .padding(.trailing, 8)
                            .accessibilityLabel(Text(verbatim: ""))
                    } label: {
                        Self.label()
                    }
            }
        }
#else
        EmptyView()
#endif
    }
}

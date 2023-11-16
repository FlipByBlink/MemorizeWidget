import SwiftUI
import WidgetKit

struct 🎛️RandomModeToggle: View {
    @EnvironmentObject var model: 📱AppModel
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var body: some View {
        Toggle(isOn: self.$model.randomMode) {
            switch self.horizontalSizeClass {
                case .compact:
                    Label("Random mode", systemImage: "shuffle")
                default:
                    LabeledContent {
                        Self.captionForIPad()
                    } label: {
                        Label("Random mode", systemImage: "shuffle")
                    }
            }
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
    private static func captionForIPad() -> some View {
#if os(iOS)
        Group {
            if UIDevice.current.userInterfaceIdiom == .pad {
                Text("Per 5 minutes")
                    .font(.caption.weight(.light))
                    .padding(.trailing, 8)
            } else {
                EmptyView()
            }
        }
#else
        EmptyView()
#endif
    }
}

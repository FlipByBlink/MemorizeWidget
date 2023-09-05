import SwiftUI

struct 🪧ContainerBackground: ViewModifier {
    @Environment(\.widgetFamily) var widgetFamily
    @Environment(\.widgetRenderingMode) var widgetRenderingMode
    @Environment(\.showsWidgetContainerBackground) var showsWidgetContainerBackground
    private var isSmartStask: Bool {
        #if os(watchOS)
        self.widgetFamily == .accessoryRectangular
        && self.widgetRenderingMode == .fullColor
        && self.showsWidgetContainerBackground
        #else
        false
        #endif
    }
    func body(content: Content) -> some View {
        if #available(iOS 17.0, watchOS 10.0, *) {
            if self.isSmartStask {
                content
                    .colorInvert()
                    .containerBackground(.white, for: .widget)
            } else {
                content
                    .containerBackground(.background, for: .widget)
            }
        } else {
            content
        }
    }
}

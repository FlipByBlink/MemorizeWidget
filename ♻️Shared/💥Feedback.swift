import SwiftUI
#if os(watchOS)
import WatchKit
#endif

enum 💥Feedback {
#if os(iOS)
    static func light() {
        UISelectionFeedbackGenerator().selectionChanged()
    }
    static func success() {
        UINotificationFeedbackGenerator().notificationOccurred(.success)
    }
    static func error() {
        UINotificationFeedbackGenerator().notificationOccurred(.error)
    }
    static func warning() {
        UINotificationFeedbackGenerator().notificationOccurred(.warning)
    }
#elseif os(watchOS)
    static func light() {
        WKInterfaceDevice.current().play(.click)
    }
    static func success() {
        WKInterfaceDevice.current().play(.success)
    }
    static func error() {
        WKInterfaceDevice.current().play(.failure)
    }
    static func warning() {
//        UINotificationFeedbackGenerator().notificationOccurred(.warning)
    }
#endif
}

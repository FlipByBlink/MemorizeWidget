import WidgetKit

enum 🩹WorkaroundOnIOS15 {
    enum SyncWidget {
        static func save(_ ⓝotes: 📚Notes) {
#if os(iOS)
            if #available(iOS 16, *) {
                💾UserDefaults.appGroup.removeObject(forKey: "SyncBetweenWidgetOnIOS15")
            } else {
                💾UserDefaults.appGroup.set(ⓝotes.encode(), forKey: "SyncBetweenWidgetOnIOS15")
                WidgetCenter.shared.reloadAllTimelines()
            }
#endif
        }
#if os(iOS)
        static func loadNotes() -> 📚Notes? {
            guard let ⓓata =  💾UserDefaults.appGroup.data(forKey: "SyncBetweenWidgetOnIOS15") else { return nil }
            return 📚Notes.decode(ⓓata)
        }
#endif
    }
}

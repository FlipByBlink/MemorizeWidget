import Foundation

enum 💾ICloud {
    static var api: NSUbiquitousKeyValueStore { .default }
    static func addObserver(_ ⓞbserver: Any, _ ⓢelector: Selector) {
        NotificationCenter.default.addObserver(ⓞbserver,
                                               selector: ⓢelector,
                                               name: NSUbiquitousKeyValueStore.didChangeExternallyNotification,
                                               object: Self.api)
    }
    static func save(_ ⓝotes: 📚Notes) {
        Self.api.set(ⓝotes.encode(), forKey: "Notes")
        🩹WorkaroundOnIOS15.SyncWidget.save(ⓝotes)
    }
    static func loadNotes() -> 📚Notes? {
        if let ⓓata = Self.api.data(forKey: "Notes") {
            .decode(ⓓata)
        } else {
            nil
        }
    }
    static var notesIsNil: Bool {
        Self.loadNotes() == nil
    }
}

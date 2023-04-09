import Foundation

enum 💾ICloud {
    static var api: NSUbiquitousKeyValueStore { .default }
    
    static func addObserver(_ ⓞbserver: Any, _ ⓢelector: Selector) {
        NotificationCenter.default.addObserver(ⓞbserver,
                                               selector: ⓢelector,
                                               name: NSUbiquitousKeyValueStore.didChangeExternallyNotification,
                                               object: NSUbiquitousKeyValueStore.default)
    }
    
    static func changeReason(ⓤserInfo: [AnyHashable : Any]) -> String {
        guard let ⓥalue = ⓤserInfo[NSUbiquitousKeyValueStoreChangeReasonKey] as? Int else { return "🐛" }
        switch ⓥalue {
            case NSUbiquitousKeyValueStoreServerChange: return "NSUbiquitousKeyValueStoreServerChange"
            case NSUbiquitousKeyValueStoreInitialSyncChange: return "NSUbiquitousKeyValueStoreInitialSyncChange"
            case NSUbiquitousKeyValueStoreQuotaViolationChange: return "NSUbiquitousKeyValueStoreQuotaViolationChange"
            case NSUbiquitousKeyValueStoreAccountChange: return "NSUbiquitousKeyValueStoreAccountChange"
            default: assertionFailure(); return "🐛"
        }
    }
}

extension 💾ICloud {
    static func save(_ ⓝotes: 📚Notes) {
        Self.api.set(ⓝotes.encode(), forKey: "Notes")
    }
    static func loadNotes() -> 📚Notes? {
        guard let ⓓata = Self.api.data(forKey: "Notes") else { return nil }
        return 📚Notes.decode(ⓓata)
    }
    static var noNotes: Bool {
        Self.loadNotes() == nil
    }
}

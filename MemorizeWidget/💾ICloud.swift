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
            default: return "🐛"
        }
    }
}

extension 💾ICloud {
    static func save(_ ⓝotes: 📚Notes) {
        do {
            let ⓓata = try JSONEncoder().encode(ⓝotes)
            Self.api.set(ⓓata, forKey: "Notes")
        } catch {
            print("🚨", error); assertionFailure()
        }
    }
    static func loadNotes() -> 📚Notes? {
        guard let ⓓata = Self.api.data(forKey: "Notes") else { return nil }
        do {
            return try JSONDecoder().decode(📚Notes.self, from: ⓓata)
        } catch {
            print("🚨", error); assertionFailure()
            return []
        }
    }
}

extension 💾ICloud {
    static func insertLocalNotes(_ ⓛocalNotes: 📚Notes) {
        var ⓝewNotesSet: [📗Note] = Self.loadNotes() ?? []
        ⓛocalNotes.forEach { ⓝote in
            if !ⓝewNotesSet.contains(ⓝote) {
                ⓝewNotesSet.insert(ⓝote, at: 0)
            }
        }
        Self.save(ⓝewNotesSet)
    }
}

import Foundation

enum 💾ICloud {
    static var api: NSUbiquitousKeyValueStore { .default }
    
    static func addObserver(_ ⓞbserver: Any, _ ⓢelector: Selector) {
        NotificationCenter.default.addObserver(ⓞbserver,
                                               selector: ⓢelector,
                                               name: NSUbiquitousKeyValueStore.didChangeExternallyNotification,
                                               object: NSUbiquitousKeyValueStore.default)
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
    static func forwardFromUserDefaults_1_1_2(_ ⓝotes: 📗Note) {
        let ⓥer_1_1_2_notes: 📚Notes = [] //💾UserDefaults_1_1_2.loadNotes()
        var ⓝewNotesSet: [📗Note] = Self.loadNotes() ?? []
        ⓥer_1_1_2_notes.forEach { ⓝote in
            if !ⓝewNotesSet.contains(ⓝote) {
                ⓝewNotesSet.insert(ⓝote, at: 0)
            }
        }
        Self.save(ⓝewNotesSet)
    }
}

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

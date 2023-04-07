import Foundation

enum 💾UserDefaults_1_1_2 {
    static var appGroup: UserDefaults {
        if let ⓥalue = UserDefaults(suiteName: "group.net.aaaakkkkssssttttnnnn.MemorizeWidget") {
            return ⓥalue
        } else {
            assertionFailure(); return .standard
        }
    }
}

extension UserDefaults {
    static var ⓐppGroup: UserDefaults { 💾UserDefaults_1_1_2.appGroup }
}

extension 💾UserDefaults_1_1_2 {
    static func save(_ ⓝotes: 📚Notes) {
        do {
            let ⓓata = try JSONEncoder().encode(ⓝotes)
            Self.appGroup.set(ⓓata, forKey: "Notes")
        } catch {
            print("🚨", error); assertionFailure()
        }
    }
    static func loadNotes() -> 📚Notes? {
        guard let ⓓata = 💾UserDefaults_1_1_2.appGroup.data(forKey: "Notes") else { return nil }
        do {
            return try JSONDecoder().decode(📚Notes.self, from: ⓓata)
        } catch {
            print("🚨", error); assertionFailure()
            return []
        }
    }
    static func dataCount(_ ⓝotes: 📚Notes) -> Int {
        do {
            let ⓓata = try JSONEncoder().encode(ⓝotes)
            return ⓓata.count
        } catch {
            print("🚨", error); assertionFailure()
            return 0
        }
    }
}

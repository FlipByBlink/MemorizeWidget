import WidgetKit

enum 💾UserDefaults {
    static var appGroup: UserDefaults {
        if let ⓥalue = UserDefaults(suiteName: "group.net.aaaakkkkssssttttnnnn.MemorizeWidget") {
            return ⓥalue
        } else {
            assertionFailure(); return .standard
        }
    }
}

extension 💾UserDefaults {
    //static func save(_ ⓝotes: 📚Notes) { //Ver 1.1.2
    //    do {
    //        let ⓓata = try JSONEncoder().encode(ⓝotes)
    //        Self.appGroup.set(ⓓata, forKey: "Notes")
    //    } catch {
    //        print("🚨", error); assertionFailure()
    //    }
    //}
    static func loadNotesOfVer_1_1_2() -> 📚Notes? {
        guard let ⓓata = Self.appGroup.data(forKey: "Notes") else { return nil }
        return 📚Notes.decode(ⓓata)
    }
}

extension 💾UserDefaults {
    static var notesVer_1_1_2_IsNil: Bool {
        Self.loadNotesOfVer_1_1_2() == nil
    }
    static func clearNotesOfVer_1_1_2() {
        Self.appGroup.removeObject(forKey: "Notes")
    }
}

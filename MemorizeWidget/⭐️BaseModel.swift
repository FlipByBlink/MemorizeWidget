
import Foundation
import WidgetKit

struct 📗Note: Codable, Identifiable, Hashable {
    var title: String
    var comment: String
    var id: UUID
    
    init(_ title: String, _ comment: String = "", _ id: UUID? = nil) {
        self.title = title
        self.comment = comment
        self.id = id ?? UUID()
    }
}

let 🆔AppGroupID = "group.net.aaaakkkkssssttttnnnn.MemorizeWidget"

struct 💾DataManager {
    static let ⓤd = UserDefaults(suiteName: 🆔AppGroupID)
    static func save(_ ⓝotes: [📗Note]) {
        do {
            let ⓓata = try JSONEncoder().encode(ⓝotes)
            ⓤd?.set(ⓓata, forKey: "Notes")
            WidgetCenter.shared.reloadAllTimelines()
        } catch {
            print("🚨:", error)
        }
    }
    static var notes: [📗Note]? {//TODO: Optionalを再検討
        guard let ⓓata = ⓤd?.data(forKey: "Notes") else { return nil }
        do {
            return try JSONDecoder().decode([📗Note].self, from: ⓓata)
        } catch {
            print("🚨:", error)
            return nil
        }
    }
    static func cleanEmptyTitleNotes() {
        if var ⓝotes = Self.notes {
            ⓝotes.removeAll { $0.title == "" }
            Self.save(ⓝotes)
        }
    }
}

func 🄲onvertTextToNotes(_ ⓘnputText: String, _ ⓢeparator: 🅂eparator) -> [📗Note] {
    var ⓝotes: [📗Note] = []
    let ⓞneLineTexts: [String] = ⓘnputText.components(separatedBy: .newlines)
    ⓞneLineTexts.forEach { ⓞneLine in
        if !ⓞneLine.isEmpty {
            if ⓢeparator == .titleOnly {
                ⓝotes.append(📗Note(ⓞneLine))
            } else {
                let ⓣexts = ⓞneLine.components(separatedBy: ⓢeparator.rawValue)
                if let ⓣitle = ⓣexts.first {
                    if !ⓣitle.isEmpty {
                        let ⓒomment = ⓞneLine.dropFirst(ⓣitle.count + 1).description
                        ⓝotes.append(📗Note(ⓣitle, ⓒomment))
                    }
                }
            }
        }
    }
    return ⓝotes
}

enum 🅂eparator: String {
    case tab = "\t"
    case comma = ","
    case titleOnly = ""
}

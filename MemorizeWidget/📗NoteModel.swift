import Foundation
import WidgetKit

struct 📗Note: Codable, Identifiable, Hashable {
    var title: String
    var comment: String
    var id: UUID
    
    init(_ title: String, _ comment: String = "") {
        self.title = title
        self.comment = comment
        self.id = UUID()
    }
}

typealias 📚Notes = [📗Note]

extension 📚Notes {
    func save() {
        do {
            let ⓓata = try JSONEncoder().encode(self)
            💾appGroupDefaults?.set(ⓓata, forKey: "Notes")
            WidgetCenter.shared.reloadAllTimelines()
        } catch {
            print("🚨", error); assertionFailure()
        }
    }
    mutating func cleanEmptyTitleNotes() {
        self.removeAll { $0.title == "" }
        self.save()
    }
    static func load() -> Self? {
        guard let ⓓata = 💾appGroupDefaults?.data(forKey: "Notes") else { return nil }
        do {
            return try JSONDecoder().decode(Self.self, from: ⓓata)
        } catch {
            print("🚨", error); assertionFailure()
            return []
        }
    }
}

extension 📚Notes {
    static func convert(_ ⓘnputText: String, _ ⓢeparator: 🅂eparator) -> Self {
        var ⓝotes: Self = []
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
}

enum 🅂eparator: String {
    case tab = "\t"
    case comma = ","
    case titleOnly = ""
}

extension 📚Notes {
    static var sample: Self {
        .convert(String(localized: """
                    可愛い,cute, pretty, kawaii
                    おやすみなさい,good night.
                    苺,strawberry
                    """), 🅂eparator.comma)
    }
}

import Foundation
import WidgetKit

struct 📗Note: Codable, Identifiable, Hashable {
    var title: String
    var comment: String
    var id: UUID
    
    var isEmpty: Bool {
        self.title.isEmpty && self.comment.isEmpty
    }
    
    static var empty: Self { Self("") }
    
    init(_ title: String, _ comment: String = "") {
        self.title = title
        self.comment = comment
        self.id = UUID()
    }
}

typealias 📚Notes = [📗Note]

extension 📚Notes {
    static func load() -> Self? {
        💾ICloud.api.synchronize()
        return 💾ICloud.loadNotes()
    }
}

extension 📚Notes {
    mutating func cleanEmptyTitleNotes() {
        self.removeAll { $0.title == "" }
    }
    func index(_ ⓘd: UUID?) -> Int? {
        self.firstIndex { $0.id == ⓘd }
    }
}

extension 📚Notes {
    func encode() -> Data {
        do {
            return try JSONEncoder().encode(self)
        } catch {
            assertionFailure(); return Data()
        }
    }
    static func decode(_ ⓓata: Data) -> Self {
        do {
            return try JSONDecoder().decode(Self.self, from: ⓓata)
        } catch {
            assertionFailure(); return []
        }
    }
    var dataCount: Int { self.encode().count }
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
    static var placeholder: Self {
        .convert(String(localized: """
                    可愛い,cute, pretty, kawaii
                    おやすみなさい,good night.
                    苺,strawberry
                    """), 🅂eparator.comma)
    }
}

import Foundation

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
    static var placeholder: Self {
        [.init(.init(localized: "可愛い"), .init(localized: "cute, pretty, kawaii")),
         .init(.init(localized: "おやすみなさい"), .init(localized: "good night.")),
         .init(.init(localized: "苺"), .init(localized: "strawberry"))]
    }
}

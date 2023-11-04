import WidgetKit

struct 📗Note: Codable, Identifiable, Hashable {
    var title: String
    var comment: String
    var id: UUID
    init(_ title: String, _ comment: String = "") {
        self.title = title
        self.comment = comment
        self.id = .init()
    }
}

extension 📗Note {
    var isEmpty: Bool {
        self.title.isEmpty && self.comment.isEmpty
    }
    static var empty: Self { .init("") }
}

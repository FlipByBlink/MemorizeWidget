import Foundation

struct 🗑DeletedContent: Codable, Equatable, Identifiable {
    var date: Date
    var notes: 📚Notes
    var id: Date { self.date }
}

typealias 🗑DeletedContents = [🗑DeletedContent]

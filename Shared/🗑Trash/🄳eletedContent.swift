import Foundation

struct 🄳eletedContent: Codable, Equatable, Identifiable {
    var date: Date
    var notes: 📚Notes
    var id: Date { self.date }
}

typealias 🄳eletedContents = [🄳eletedContent]

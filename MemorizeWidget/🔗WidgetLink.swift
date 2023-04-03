import Foundation

enum 🔗WidgetLink {
    case notes([UUID]), newNoteShortcut
    var path: String {
        switch self {
            case .notes(let ⓘds):
                var ⓓescription: String = ""
                for ⓘd in ⓘds {
                    ⓓescription += ⓘd.uuidString
                    if ⓘd == ⓘds.last { break }
                    ⓓescription += "/"
                }
                print(ⓓescription)
                return "example://\(ⓓescription)"
            case .newNoteShortcut:
                return "example://NewNoteShortcut"
        }
    }
    var url: URL { URL(string: self.path)! }
    static func load(_ ⓤrl: URL) -> Self? {
        if ⓤrl.path == "NewNoteShortcut" {
            return Self.newNoteShortcut
        } else {
            return Self.notes(ⓤrl.pathComponents.compactMap { UUID(uuidString: $0) })
        }
    }
}

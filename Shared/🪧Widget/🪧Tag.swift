import Foundation

enum 🪧Tag {
    case notes([UUID])
    case newNoteShortcut
    case placeholder
}

extension 🪧Tag: Hashable {
    var urlString: String {
        switch self {
            case .notes(let ⓘds):
                var ⓟath: String = ""
                for ⓘd in ⓘds {
                    ⓟath += ⓘd.uuidString
                    if ⓘd == ⓘds.last { break }
                    ⓟath += "/"
                }
                return "example://notes/\(ⓟath)"
            case .newNoteShortcut:
                return "example://newNoteShortcut/"
            case .placeholder:
                return "example://placeholder/"
        }
    }
    var url: URL { .init(string: self.urlString)! }
    var pickedNotesIDs: [UUID] { //TODO: 削除検討
        switch self {
            case .notes(let ⓘds):
                return ⓘds
            case .newNoteShortcut, .placeholder:
                assertionFailure()
                return []
        }
    }
    static func decode(_ ⓤrl: URL) -> Self? {
        switch ⓤrl.host {
            case "notes":
                return Self.notes(ⓤrl.pathComponents.compactMap { .init(uuidString: $0) })
            case "newNoteShortcut":
                return Self.newNoteShortcut
            case "placeholder":
                return Self.placeholder
            default:
                assertionFailure()
                return nil
        }
    }
}

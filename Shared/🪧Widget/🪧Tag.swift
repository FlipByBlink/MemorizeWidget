import Foundation

enum 🪧Tag {
    case notes([UUID])
    case newNoteShortcut
    case placeholder
}

extension 🪧Tag: Hashable {
    func encode() -> URL {
        switch self {
            case .notes(let ⓘds):
                var ⓟath: String = ""
                for ⓘd in ⓘds {
                    ⓟath += ⓘd.uuidString
                    if ⓘd == ⓘds.last { break }
                    ⓟath += "/"
                }
                return .init(string: "example://notes/\(ⓟath)")!
            case .newNoteShortcut:
                return .init(string: "example://newNoteShortcut/")!
            case .placeholder:
                return .init(string: "example://placeholder/")!
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

import Foundation

struct 🪧WidgetState {
    var showSheet: Bool = false
    var type: 🅃ype? = nil
    enum 🅃ype {
        case singleNote(UUID), multiNotes([UUID]), newNoteShortcut
        var description: String {
            switch self {
                case .singleNote(let ⓘd):
                    return "example://singleNote/\(ⓘd.uuidString)"
                case .multiNotes(let ⓘds):
                    var ⓟath: String = ""
                    for ⓘd in ⓘds {
                        ⓟath += ⓘd.uuidString
                        if ⓘd == ⓘds.last { break }
                        ⓟath += "/"
                    }
                    return "example://multiNotes/\(ⓟath)"
                case .newNoteShortcut:
                    return "example://NewNoteShortcut/"
            }
        }
        var url: URL { URL(string: self.description)! }
        static func load(_ ⓤrl: URL) -> Self? {
            switch ⓤrl.host {
                case "singleNote":
                    guard let ⓘd = UUID(uuidString: ⓤrl.path) else { return nil }
                    return Self.singleNote(ⓘd)
                case "multiNotes":
                    return Self.multiNotes(ⓤrl.pathComponents.compactMap { UUID(uuidString: $0) })
                case "NewNoteShortcut":
                    return Self.newNoteShortcut
                default:
                    assertionFailure(); return nil
            }
        }
    }
    static var `default`: Self { Self(showSheet: false, type: nil) }
}

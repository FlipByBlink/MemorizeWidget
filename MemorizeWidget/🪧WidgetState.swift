import Foundation

struct 🪧WidgetState {
    var showSheet: Bool = false
    var type: 🅃ype? = nil
    enum 🅃ype {
        case singleNote(UUID), multiNotes([UUID]), newNoteShortcut
        var path: String {
            switch self {
                case .singleNote(let ⓘd):
                    return "example://\(ⓘd.uuidString)"
                case .multiNotes(let ⓘds):
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
            if ⓤrl.pathComponents.count == 1 {
                if ⓤrl.path == "NewNoteShortcut" {
                    return Self.newNoteShortcut
                } else {
                    guard let ⓘd = UUID(uuidString: ⓤrl.path) else { return nil }
                    return Self.singleNote(ⓘd)
                }
            } else {
                return Self.multiNotes(ⓤrl.pathComponents.compactMap { UUID(uuidString: $0) })
            }
        }
    }
    static var `default`: Self { Self(showSheet: false, type: nil) }
}

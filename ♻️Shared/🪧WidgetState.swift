import Foundation
import WidgetKit

struct 🪧WidgetState {
    var showSheet: Bool
    var info: 🪧WidgetInfo?
    static var `default`: Self { Self(showSheet: false, info: nil) }
}

enum 🪧WidgetInfo {
    case singleNote(UUID), multiNotes([UUID]), newNoteShortcut, noNote
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
            case .noNote:
                return "example://noNote/"
        }
    }
    var url: URL { URL(string: self.description)! }
    static func load(_ ⓤrl: URL) -> Self? {
        switch ⓤrl.host {
            case "singleNote":
                guard let ⓘd = UUID(uuidString: ⓤrl.lastPathComponent) else { return nil }
                return Self.singleNote(ⓘd)
            case "multiNotes":
                return Self.multiNotes(ⓤrl.pathComponents.compactMap { UUID(uuidString: $0) })
            case "NewNoteShortcut":
                return Self.newNoteShortcut
            case "noNote":
                return Self.noNote
            default:
                assertionFailure(); return nil
        }
    }
    var notes: 📚Notes {
        guard let ⓝotes = 💾ICloud.loadNotes() else { return [] }
        switch self {
            case .singleNote(let ⓘd):
                guard let ⓝote = ⓝotes.first(where: { $0.id == ⓘd }) else { return [] }
                return [ⓝote]
            case .multiNotes(let ⓘds):
                return ⓘds.compactMap { ⓘd in
                    ⓝotes.first { $0.id == ⓘd }
                }
            default:
                return []
        }
    }
}

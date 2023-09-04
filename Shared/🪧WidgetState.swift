import Foundation
import WidgetKit

struct 🪧WidgetState {
    var showSheet: Bool
    var info: 🪧WidgetInfo?
    static var `default`: Self { Self(showSheet: false, info: nil) }
}

enum 🪧WidgetInfo {
    case singleNote(UUID), multiNotes([UUID]), newNoteShortcut, noNote, widgetPlaceholder
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
            case .widgetPlaceholder:
                return "example://"
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
    var targetedNotes: 📚Notes {
        let ⓝotes: 📚Notes
        if #available(iOS 16, *) {
            ⓝotes = 💾ICloud.loadNotes() ?? []
        } else {
            ⓝotes = 🩹WorkaroundOnIOS15.SyncWidget.loadNotes() ?? []
        }
        switch self {
            case .singleNote(let ⓘd):
                guard let ⓝote = ⓝotes.first(where: { $0.id == ⓘd }) else { return [] }
                return [ⓝote]
            case .multiNotes(let ⓘds):
                return ⓘds.compactMap { ⓘd in
                    ⓝotes.first { $0.id == ⓘd }
                }
            case .widgetPlaceholder:
                return [.init("Palceholder")]
            default:
                return []
        }
    }
    var targetedNotesCount: Int? {
        switch self {
            case .singleNote(_): return 1
            case .multiNotes(let ⓘds): return ⓘds.count
            case .newNoteShortcut, .noNote: return nil
            case .widgetPlaceholder: return 1
        }
    }
    var targetedNoteIDs: [UUID]? {
        switch self {
            case .singleNote(let ⓘd): return [ⓘd]
            case .multiNotes(let ⓘds): return ⓘds
            case .newNoteShortcut, .noNote: return nil
            case .widgetPlaceholder: return [UUID()]
        }
    }
}

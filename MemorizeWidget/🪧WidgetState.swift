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
        guard let ⓝotes = 📚Notes.load() else { return [] }
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

struct 🕒WidgetEntry: TimelineEntry {
    let date: Date
    let info: 🪧WidgetInfo
    
    init(_ date: Date, _ info: 🪧WidgetInfo) {
        self.date = date
        self.info = info
    }
    
    static func generateEntry(_ ⓓate: Date, _ ⓦidgetFamily: WidgetFamily) -> Self {
        let ⓝotes: 📚Notes = .load() ?? []
        guard !ⓝotes.isEmpty else { return Self(.now, .noNote) }
        if 💾UserDefaults.appGroup.bool(forKey: "multiNotes") {
            if 💾UserDefaults.appGroup.bool(forKey: "RandomMode") {
                let ⓟickedShuffleNotes = ⓝotes.shuffled().prefix(ⓦidgetFamily.ⓜultiNotesCount).map { $0.id }
                let ⓘnfo = 🪧WidgetInfo.multiNotes(ⓟickedShuffleNotes)
                return Self(ⓓate, ⓘnfo)
            } else {
                let ⓘnfo = 🪧WidgetInfo.multiNotes(ⓝotes.prefix(ⓦidgetFamily.ⓜultiNotesCount).map { $0.id })
                return Self(ⓓate, ⓘnfo)
            }
        } else {
            if 💾UserDefaults.appGroup.bool(forKey: "RandomMode") {
                guard let ⓝote = ⓝotes.randomElement() else {
                    assertionFailure(); return  Self(ⓓate, .noNote)
                }
                return Self(ⓓate, .singleNote(ⓝote.id))
            } else {
                guard let ⓝote = ⓝotes.first else {
                    assertionFailure(); return Self(ⓓate, .noNote)
                }
                return Self(ⓓate, .singleNote(ⓝote.id))
            }
        }
    }
    
    static func generateTimeline(_ ⓦidgetFamily: WidgetFamily) -> Timeline<Self> {
        let ⓝotes: 📚Notes = .load() ?? []
        guard !ⓝotes.isEmpty else { return Timeline(entries: [Self(.now, .noNote)], policy: .never) }
        if 💾UserDefaults.appGroup.bool(forKey: "multiNotes") {
            var ⓔntries: [Self] = []
            for ⓒount in 0 ..< 12 {
                let ⓞffset = ⓒount * 5
                let ⓓate = Calendar.current.date(byAdding: .minute, value: ⓞffset, to: .now)!
                ⓔntries.append(Self.generateEntry(ⓓate, ⓦidgetFamily))
            }
            return Timeline(entries: ⓔntries, policy: .atEnd)
        } else {
            return Timeline(entries: [Self.generateEntry(.now, ⓦidgetFamily)],
                            policy: .after(Calendar.current.date(byAdding: .minute, value: 60, to: .now)!))
        }
    }
}

extension WidgetFamily {
    var ⓜultiNotesCount: Int {
        switch self {
            case .systemSmall: return 3
            case .systemMedium: return 3
            case .systemLarge: return 6
            case .systemExtraLarge: return 12
            case .accessoryCircular: return 2
            case .accessoryRectangular: return 3
            case .accessoryInline: return 1
            @unknown default: return 1
        }
    }
}

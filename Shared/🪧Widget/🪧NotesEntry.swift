import WidgetKit

struct 🪧NotesEntry: TimelineEntry {
    let date: Date
    var kind: 🪧Kind
    var phase: 🪧Phase
    var pickedNotes: 📚Notes
    init(date: Date, kind: 🪧Kind, phase: 🪧Phase, context: TimelineProviderContext) {
        self.date = date
        self.kind = kind
        self.phase = phase
        switch phase {
            case .placeholder:
                self.pickedNotes = []
            case .snapshot, .inTimeline:
                let ⓝoteCount = Self.notesCount(context.family)
                self.pickedNotes = Self.pickNotes(kind, ⓝoteCount)
        }
    }
}

extension 🪧NotesEntry {
    var tag: 🪧Tag {
        switch self.phase {
            case .placeholder:
                return .placeholder
            case .snapshot, .inTimeline:
                switch self.kind {
                    case .newNoteShortcut:
                        assertionFailure()
                        return .newNoteShortcut
                    case .primary, .sub:
                        return .notes(self.pickedNotes.map { $0.id })
                }
        }
    }
}

private extension 🪧NotesEntry {
    private static func notesCount(_ ⓦidgetFamily: WidgetFamily) -> Int {
        if 🎛️Option.multiNotesMode {
            switch ⓦidgetFamily {
                case .systemSmall, .systemMedium:
                    🎛️Option.showCommentMode ? 2 : 3
                case .systemLarge, .systemExtraLarge:
                    🎛️Option.showCommentMode ? 4 : 5
                case .accessoryCircular, .accessoryInline:
                    1
                case .accessoryRectangular:
                    🎛️Option.showCommentMode ? 1 : 3
#if os(watchOS)
                case .accessoryCorner:
                    1
#endif
                @unknown default:
                    1
            }
        } else {
            1
        }
    }
    private static func pickNotes(_ ⓚind: 🪧Kind, _ ⓒount: Int) -> 📚Notes {
        var ⓐllNotes = .load() ?? []
        if 🎛️Option.randomMode {
            return Array(ⓐllNotes.shuffled().prefix(ⓒount))
        } else {
            guard !ⓐllNotes.isEmpty else { return [] }
            if ⓚind == .sub {
                ⓐllNotes = .init(ⓐllNotes.dropFirst(ⓒount))
            }
            return Array(ⓐllNotes.prefix(ⓒount))
        }
    }
}

import WidgetKit

struct 🪧Entry: TimelineEntry {
    let date: Date
    var kind: 🪧Kind
    var phase: 🪧Phase
    var timelineProviderContext: TimelineProviderContext
    var targetedNotes: 📚Notes?
    init(date: Date, kind: 🪧Kind, phase: 🪧Phase, context: TimelineProviderContext) {
        self.date = date
        self.kind = kind
        self.phase = phase
        self.timelineProviderContext = context
        self.targetedNotes = self.pickNotes()
    }
}

extension 🪧Entry {
    func pickNotes() -> 📚Notes {
        var ⓐllNotes: 📚Notes = .load() ?? []
        if 🎛️Option.randomMode {
            return Array(ⓐllNotes.shuffled().prefix(self.notesCount))
        } else {
            guard !ⓐllNotes.isEmpty else { return [] }
            if self.kind == .sub {
                ⓐllNotes.removeFirst(self.notesCount)
            }
            return Array(ⓐllNotes.prefix(self.notesCount))
        }
    }
    var tag: 🪧Tag {
        switch self.phase {
            case .placeholder:
                return .placeholder
            case .snapshot, .inTimeline:
                switch self.kind {
                    case .newNoteShortcut:
                        return .newNoteShortcut
                    case .primary, .sub:
                        guard let targetedNotes else {
                            assertionFailure()
                            return .notes([])
                        }
                        return .notes(targetedNotes.map { $0.id })
                }
        }
    }
    private var notesCount: Int {
        if 🎛️Option.multiNotesMode {
            switch self.timelineProviderContext.family {
                case .systemSmall, .systemMedium:
                    🎛️Option.showCommentMode ? 2 : 3
                case .systemLarge, .systemExtraLarge:
                    🎛️Option.showCommentMode ? 6 : 5
                case .accessoryCorner, .accessoryCircular, .accessoryInline:
                    1
                case .accessoryRectangular:
                    🎛️Option.showCommentMode ? 1 : 3
                @unknown default:
                    1
            }
        } else {
            1
        }
    }
}

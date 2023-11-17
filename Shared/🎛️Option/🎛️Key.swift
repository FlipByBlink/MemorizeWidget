enum 🎛️Key {
    static let multiNotesMode = "multiNotes"
    static let randomMode = "RandomMode"
    static let showCommentMode = "ShowComment"
    enum Import {
        static let inputMode = "InputMode"
        static let textSeparator = "separator"
    }
    enum Search {
        static let leadingText = "SearchLeadingText"
        static let trailingText = "SearchTrailingText"
        static let openURLInOtherApp = "openURLInOtherApp"
    }
    enum FontSize {
        static let customize = "customizeFontSize"
        enum SystemFamily {
            static let title = "titleSizeForSystemFamily"
            static let comment = "commentSizeForSystemFamily"
        }
        enum AccessoryFamily {
            static let title = "titleSizeForAccessoryFamily"
            static let comment = "commentSizeForAccessoryFamily"
        }
    }
}

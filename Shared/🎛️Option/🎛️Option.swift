enum 🎛️Option {
    static var multiNotesMode: Bool { 💾UserDefaults.appGroup.bool(forKey: "multiNotes") }
    static var randomMode: Bool { 💾UserDefaults.appGroup.bool(forKey: "RandomMode") }
    static var showCommentMode: Bool { 💾UserDefaults.appGroup.bool(forKey: "ShowComment") }
    static var customizeFontSize: Bool { 💾UserDefaults.appGroup.bool(forKey: "customizeFontSize") }
    static var titleSizeForSystemFamily: Int { 💾UserDefaults.appGroup.integer(forKey: "titleSizeForSystemFamily") }
    static var commentSizeForSystemFamily: Int { 💾UserDefaults.appGroup.integer(forKey: "commentSizeForSystemFamily") }
    static var titleSizeForAccessoryFamily: Int { 💾UserDefaults.appGroup.integer(forKey: "titleSizeForAccessoryFamily") }
    static var commentSizeForAccessoryFamily: Int { 💾UserDefaults.appGroup.integer(forKey: "commentSizeForAccessoryFamily") }
}

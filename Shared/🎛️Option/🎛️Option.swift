enum 🎛️Option {
    static var multiNotesMode: Bool { 💾UserDefaults.appGroup.bool(forKey: "multiNotes") }
    static var randomMode: Bool { 💾UserDefaults.appGroup.bool(forKey: "RandomMode") }
    static var showCommentMode: Bool { 💾UserDefaults.appGroup.bool(forKey: "ShowComment") }
}

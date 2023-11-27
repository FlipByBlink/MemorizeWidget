enum 🎛️Option {
    static var multiNotesMode: Bool { 💾UserDefaults.appGroup.bool(forKey: 🎛️Key.multiNotesMode) }
    static var randomMode: Bool { 💾UserDefaults.appGroup.bool(forKey: 🎛️Key.randomMode) }
    static var showCommentMode: Bool { 💾UserDefaults.appGroup.bool(forKey: 🎛️Key.showCommentMode) }
    static var multilineTextAlignment: 🎛️MultilineTextAlignment { .loadUserDeaults() }
    static var customizeFontSize: Bool { 💾UserDefaults.appGroup.bool(forKey: 🎛️Key.FontSize.customize) }
    enum FontSize {
        enum SystemFamily {
            static var title: Int { 💾UserDefaults.appGroup.integer(forKey: 🎛️Key.FontSize.SystemFamily.title) }
            static var comment: Int { 💾UserDefaults.appGroup.integer(forKey: 🎛️Key.FontSize.SystemFamily.comment) }
        }
        enum AccessoryFamily {
            static var title: Int { 💾UserDefaults.appGroup.integer(forKey: 🎛️Key.FontSize.AccessoryFamily.title) }
            static var comment: Int { 💾UserDefaults.appGroup.integer(forKey: 🎛️Key.FontSize.AccessoryFamily.comment) }
        }
    }
}

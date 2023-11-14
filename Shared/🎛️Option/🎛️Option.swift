enum 🎛️Option {
    static var multiNotesMode: Bool { 💾UserDefaults.appGroup.bool(forKey: "multiNotes") }
    static var randomMode: Bool { 💾UserDefaults.appGroup.bool(forKey: "RandomMode") }
    static var showCommentMode: Bool { 💾UserDefaults.appGroup.bool(forKey: "ShowComment") }
    static var widgetTitleSizeForSingleMode: 🎛️WidgetTitleSizeForSingleMode {
        if let ⓢtring = 💾UserDefaults.appGroup.string(forKey: "widgetTitleSizeForSingleMode") {
            .init(rawValue: ⓢtring) ?? .default
        } else {
            .default
        }
    }
}

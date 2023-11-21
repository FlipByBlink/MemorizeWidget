enum 🎛️Default {
    enum FontSize {
        enum SystemFamily {
            static let title = 24
            static let comment = 17
        }
        enum AccessoryFamily {
            static let title = 17
            static let comment = 13
        }
    }
    static func setValues() {
        if 💾UserDefaults.appGroup.bool(forKey: "setDefaultValues") == false {
            💾UserDefaults.appGroup.set(Self.FontSize.SystemFamily.title,
                                        forKey: 🎛️Key.FontSize.SystemFamily.title)
            💾UserDefaults.appGroup.set(Self.FontSize.SystemFamily.comment,
                                        forKey: 🎛️Key.FontSize.SystemFamily.comment)
            💾UserDefaults.appGroup.set(Self.FontSize.AccessoryFamily.title,
                                        forKey: 🎛️Key.FontSize.AccessoryFamily.title)
            💾UserDefaults.appGroup.set(Self.FontSize.AccessoryFamily.comment,
                                        forKey: 🎛️Key.FontSize.AccessoryFamily.comment)
            💾UserDefaults.appGroup.set(true, forKey: "setDefaultValues")
        }
    }
    enum Search {
        static var openURLInOtherApp: Bool {
#if os(iOS)
            false
#elseif os(macOS)
            true
#endif
        }
    }
}

enum 🎛️WidgetTitleSizeForSingleMode: String {
    case small, `default`, large
}

extension 🎛️WidgetTitleSizeForSingleMode: Identifiable, CaseIterable {
    var id: Self { self }
}

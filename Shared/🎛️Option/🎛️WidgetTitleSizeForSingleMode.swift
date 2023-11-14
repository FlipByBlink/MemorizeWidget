enum 🎛️WidgetTitleSizeForSingleMode: String {
    case small, `default`, max
}

extension 🎛️WidgetTitleSizeForSingleMode: Identifiable, CaseIterable {
    var id: Self { self }
}

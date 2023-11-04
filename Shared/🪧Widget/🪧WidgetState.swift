struct 🪧WidgetState {
    var showSheet: Bool
    var info: 🪧WidgetInfo?
    static var `default`: Self { .init(showSheet: false, info: nil) }
}

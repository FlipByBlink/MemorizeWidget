import WidgetKit

struct 🪧Provider: TimelineProvider {
    func placeholder(in context: Context) -> 🪧WidgetEntry { .init(.now, .widgetPlaceholder) }
    func getSnapshot(in context: Context, completion: @escaping (🪧WidgetEntry) -> ()) {
        completion(.generateEntry(.now, context.family))
    }
    func getTimeline(in context: Context, completion: @escaping (Timeline<🪧WidgetEntry>) -> ()) {
        completion(🪧WidgetEntry.generateTimeline(context.family))
    }
}

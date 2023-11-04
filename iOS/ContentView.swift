import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        🔖TabView()
            .onOpenURL(perform: self.model.handleWidgetURL)
            .modifier(📖WidgetSheetHandler())
            .modifier(📥NotesImportSheet())
            .modifier(💬RequestUserReview())
            .modifier(🩹Workaround.HideTitleBarOnMacCatalyst())
    }
}

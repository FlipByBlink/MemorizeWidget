import SwiftUI

struct 📖WidgetSheetView: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        NavigationStack {
            Group {
                if self.model.widgetState.info?.targetedNotesCount == 1 {
                    📖SigleNoteLayoutView()
                } else {
                    📖MultiNotesLayoutView()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { 📖DismissButton() }
        }
        .modifier(📣ADSheet())
    }
}

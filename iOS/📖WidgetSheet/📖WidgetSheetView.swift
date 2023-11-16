import SwiftUI

struct 📖WidgetSheetView: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        NavigationStack {
            Group {
                if self.model.openedWidgetNotesCount == 1 {
                    📖SingleNoteLayoutView()
                } else {
                    📖MultiNotesLayoutView()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .modifier(📰SheetOnWidgetSheet.Handler())
            .toolbar { 📰DismissButton() }
        }
    }
}

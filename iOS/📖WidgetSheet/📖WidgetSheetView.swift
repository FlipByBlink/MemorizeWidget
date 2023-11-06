import SwiftUI

struct 📖WidgetSheetView: View {
    @EnvironmentObject var model: 📱AppModel
    private var notesCount: Int? {
        self.model.presentedSheetOnContentView?.widgetInfo?.targetedNotesCount
    }
    var body: some View {
        NavigationStack {
            Group {
                if self.notesCount == 1 {
                    📖SigleNoteLayoutView()
                } else {
                    📖MultiNotesLayoutView()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { 📖DismissButton() }
        }
        .modifier(📖SheetOnWidgetSheet.Handler())
    }
}

import SwiftUI

struct 📖WidgetSheetView: View { //MARK: WIP
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        NavigationStack {
            Group {
                if self.model.openedWidgetNotesCount == 1 {
                    Text("📖SingleNoteLayoutView()")
                } else {
                    Text("📖MultiNotesLayoutView()")
                }
            }
            //.modifier(📰SheetOnWidgetSheet.Handler())
            //.toolbar { 📰DismissButton() }
        }
    }
}

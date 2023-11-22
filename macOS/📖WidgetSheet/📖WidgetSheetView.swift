import SwiftUI

struct 📖WidgetSheetView: View { //MARK: WIP
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
            //.modifier(📰SheetOnWidgetSheet.Handler())
            //.toolbar { 📰DismissButton() }
        }
    }
}

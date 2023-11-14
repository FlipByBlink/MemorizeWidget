import SwiftUI

struct 🎛️OptionTab: View {
    var body: some View {
        NavigationStack {
            List {
                🎛️OptionViewComponent.WidgetTitleSizeForSingleModePicker()
                🎛️MultiNotesOnWidgetOption()
                🎛️CommentOnWidgetOption()
                🔍CustomizeSearchSheetButton()
            }
            .navigationTitle("Option")
        }
    }
}

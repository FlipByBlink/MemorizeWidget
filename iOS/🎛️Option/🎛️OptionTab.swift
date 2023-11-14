import SwiftUI

struct 🎛️OptionTab: View {
    var body: some View {
        NavigationStack {
            List {
                🎛️MultiNotesOnWidgetOption()
                🎛️CommentOnWidgetOption()
                🔍CustomizeSearchSheetButton()
            }
            .navigationTitle("Option")
        }
    }
}
